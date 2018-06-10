module TypeCheck where

import Datatypes
import Memory

import ParYmyLang
import LexYmyLang
import AbsYmyLang
import PrintYmyLang
import ErrM

import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Except
import Control.Monad.Identity
import Data.Map

type TypeCheckResult = ExceptT String IO

typeCheck :: Env -> Store -> Program -> TypeCheckResult ()
typeCheck env store (Progr []) = return ()
typeCheck env store (Progr (stmt:stmts)) = do
  (env', store') <- runReaderT (runStateT (checkRunStmt stmt) store) env
  typeCheck env' store' (Progr stmts) 

checkRunStmt :: Stmt -> PartialResult (Env)
checkRunStmt (DeclS decl) = do
  env' <- checkDecl decl
  return env'
checkRunStmt stmt = do
  env' <- ask
  checkStmt stmt Tinvalid
  return env'
  
checkDecl :: Decl_stmt -> PartialResult Env
checkDecl (DeclVar (Declarator name varType)) = declare name varType
checkDecl (DeclFn (Declarator name fnType) args stmt) = checkDefFun name fnType args stmt

checkDefFun :: Ident -> Type -> [Dec] -> Stmt -> PartialResult Env
checkDefFun fnName fnType args stmt = do
  reversedArgTypes <- parseDeclTypes args []
  argTypes <- return $ reverse $ reversedArgTypes
  returnType <- checkFunArgs fnType argTypes
  env <- ask
  env1 <- local (const env) $ declare fnName fnType
  env2 <- local (const env1) $ addArguments args [fnName]
  local (const env2) $ checkStmt stmt returnType
  loc <- local (const env1) $ getloc (Evar fnName)
  store <- get
  case Data.Map.lookup loc store of
    Nothing -> throwError "Failed to declare Function."
    otherwise -> local (const env1) $ modify (Data.Map.insert loc (fnType, Undefined))

  return env1

parseDeclTypes :: [Dec] -> [Type] -> PartialResult [Type]
parseDeclTypes [] acc = return acc
parseDeclTypes ((Declarator _ argType):args) acc = parseDeclTypes args (argType:acc)

checkFunArgs :: Type -> [Type] -> PartialResult Type  
checkFunArgs (Tfunarg Tunit fnTypeResult) [] = do
  case fnTypeResult of
    (Tfunarg _ _) -> throwError "Cannot take arguments after found Unit in declaration."
    otherwise -> return fnTypeResult
checkFunArgs (Tfunarg _ _) [] = throwError "Invalid number of arguments passed to function."
checkFunArgs fnType [] = return fnType 

checkFunArgs (Tfunarg argDeclType fnTypeResult) (argActualType:argsTypes) = do
  case argDeclType == argActualType of
    True -> checkFunArgs fnTypeResult argsTypes
    otherwise -> case argDeclType of 
      (Tfun firstArg resType) -> do 
        case (Tfunarg firstArg resType) == argActualType of
          True -> checkFunArgs fnTypeResult argsTypes
          False -> throwError "Argument type is invalid."
      (expectedType) -> throwError $ "Expected type: '" ++ (show expectedType) ++ "', got: '" ++ (show argActualType) ++ "'."
    
checkFunArgs _ _ = throwError "Invalid number of arguments passed to function."

addArguments :: [Dec] -> [Ident] -> PartialResult Env
addArguments [] _ = do
  env <- ask
  return env

addArguments ((Declarator argName argActualType):args) usedNames = do
  case elem argName usedNames of 
    True -> throwError $ "Multiple usage of name " ++ (show argName) ++ " in declaration of " ++ (show $ last usedNames)
    otherwise -> do
      env <- ask
      env1 <- local (const env) $ addArguments args (argName:usedNames)
      env2 <- local (const env1) $ declare argName argActualType
      return env2
      
checkStmt :: Stmt -> Type -> PartialResult FTypedVal
checkStmt (ExprS stmt) _ = checkExprStmt stmt 
checkStmt (CompS stmt) returnType = checkCompoundStmt stmt returnType
checkStmt (SelS stmt) returnType = checkSelStmt stmt returnType
checkStmt (IterS stmt) returnType = checkIterStmt stmt returnType
checkStmt (FlowS stmt) returnType = checkFlowStmt stmt returnType
checkStmt (PrintS stmt) _ = checkPrintStmt stmt

checkCompoundStmt :: Compound_stmt -> Type -> PartialResult FTypedVal
checkCompoundStmt (Scomp []) retType = return $ Right (Tunit, Undefined)
checkCompoundStmt (Scomp ((DeclS decl):stmts)) retType = do
  env' <- checkDecl decl
  res <- local (const env') (checkCompoundStmt (Scomp stmts) retType)
  return res
checkCompoundStmt (Scomp (stmt:stmts)) retType = do
  res <- checkStmt stmt retType
  case res of
    (Left FReturnVoid) -> do
      case retType of
        Tunit -> return $ Left FReturnVoid
        otherwise -> throwError "Invalid return type"
    (Left (FReturn (actualRetType, retVal))) -> do
      case actualRetType == retType of
        True -> return $ Left $ FReturn (actualRetType, retVal)
        False -> throwError "Invalid return type"
    otherwise -> do
      res <- checkCompoundStmt (Scomp stmts) retType
      return res
      
      
checkFlowStmt :: Flow_stmt -> Type -> PartialResult FTypedVal
checkFlowStmt Scontinue _ = return $ Left FContinue
checkFlowStmt Sbreak _ = return $ Left FBreak
checkFlowStmt SreturnVoid returnType = do 
  case returnType of 
    Tunit -> return $ Left FReturnVoid
    otherwise -> throwError $ "Invalid return type, expected: " ++ (show returnType) ++ ", got: Unit"
checkFlowStmt (Sreturn expr) expectedRetType = do
  (actualRetType, retVal) <- checkExpr expr
  case expectedRetType == actualRetType of
    True -> return $ Left $ FReturn (actualRetType, retVal) 
    False -> throwError $ "Invalid return type, expected: " ++ (show expectedRetType) ++ ", got: " ++ (show actualRetType)

checkPrintStmt :: Print_stmt -> PartialResult FTypedVal
checkPrintStmt (Sprint exp) = do 
  res <- checkExpr exp
  return $ Right res
  
checkSelStmt :: Selection_stmt -> Type -> PartialResult FTypedVal
checkSelStmt (Sif condExp stmt) returnType = checkIfElse condExp stmt (ExprS SexprEmpty) returnType
checkSelStmt (SifElse condExp stmtTrue stmtFalse) returnType = checkIfElse condExp stmtTrue stmtFalse returnType

checkIfElse :: Exp -> Stmt -> Stmt -> Type -> PartialResult FTypedVal
checkIfElse condExp stmtTrue stmtFalse returnType = do
  (varType, val) <- checkExpr condExp
  case varType of
    Tbool -> do
      checkStmt stmtTrue returnType
      checkStmt stmtFalse returnType
    otherwise -> throwError "Condition in if-statement must be boolean expression."
    
    
checkIterStmt :: Iter_stmt -> Type -> PartialResult FTypedVal
checkIterStmt (Swhile condExp evalStmt) returnType = checkLoop condExp evalStmt returnType
checkIterStmt (Sfor initExpStmt condExpStmt incrExp evalStmt) returnType = checkFor condExpStmt evalStmt returnType
checkIterStmt (Sfornoinc initExpStmt condExpStmt evalStmt) returnType = checkFor condExpStmt evalStmt returnType

checkFor :: Expression_stmt -> Stmt -> Type -> PartialResult FTypedVal
checkFor (Sexpr condExp) evalStmt returnType = do
  (varType, _) <- checkExpr condExp
  case varType of
    Tbool -> checkStmt evalStmt returnType  
    otherwise -> throwError "Condition in if-statement must be boolean expression."
checkFor SexprEmpty evalStmt returnType = checkStmt evalStmt returnType
  
checkLoop :: Exp -> Stmt -> Type -> PartialResult FTypedVal
checkLoop condExp stmt returnType = do
  (varType, _) <- checkExpr condExp
  case varType of
    Tbool -> checkStmt stmt returnType  
    otherwise -> throwError "Condition in if-statement must be boolean expression."
    
checkExprStmt :: Expression_stmt -> PartialResult FTypedVal
checkExprStmt SexprEmpty = return $ Right (Tunit, Undefined)
checkExprStmt (Sexpr expr) = do
  res <- checkExpr expr
  return $ Right res
  
checkExpr :: Exp -> PartialResult TypedVal

checkExpr (Eassign e1 op e2) = do 
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) of
    True -> return (t1, Undefined)
    False -> throwError $ "Unsupported operand type(s) for =: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 

checkExpr (Econdition be e1 e2) = do
  (beType, _) <- checkExpr be
  case beType of
    Tbool -> do
      (t1, _) <- checkExpr e1
      (t2, _) <- checkExpr e2
      case t1 == t2 of
        True -> return (t1, Undefined)
        False -> throwError $ "Unsupported operand type(s) for ?: '" ++ (show beType) ++ "', '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "', return types must be the same." 
    otherwise -> throwError $ "Unsupported operand type(s) for ?: '" ++ (show beType) ++ "' as condition." 

checkExpr (Econst const) = checkConst const
checkExpr (Evar ident) = checkVar ident --dsdd
checkExpr (Eplus e1 e2) = do -- dsds
    (t1, _) <- checkExpr e1
    (t2, _) <- checkExpr e2
    case t1 == t2 of
      True -> return (t1, Undefined)
      False -> throwError $ "Unsupported operand type(s) for +: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
      
checkExpr (Etimes e1 e2) = do
    (t1, _) <- checkExpr e1
    (t2, _) <- checkExpr e2
    case t1 == t2 of
      True -> do
        case t1 of
          Tint -> return (Tint, Undefined)
          otherwise -> throwError $ "Unsupported operand type(s) for *: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
      False -> do
        case t1 of
          (Tarray _) -> do
            case t2 of
              Tint -> return (t1, Undefined)
              otherwise -> throwError $ "Unsupported operand type(s) for *: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
          otherwise -> do
            case t2 of
              (Tarray _) -> do
                case t1 of
                  Tint -> return (t2, Undefined)
                  otherwise -> throwError $ "Unsupported operand type(s) for *: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
              otherwise -> throwError $ "Unsupported operand type(s) for *: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 

checkExpr (Eminus e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tint, Undefined)
    False -> throwError $ "Unsupported operand type(s) for /: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
  
checkExpr (Ediv e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tint, Undefined)
    False -> throwError $ "Unsupported operand type(s) for /: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
  
checkExpr (Emod e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tint, Undefined)
    False -> throwError $ "Unsupported operand type(s) for /: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 

checkExpr (Elor be1 be2) = do
  (t1, _) <- checkExpr be1
  (t2, _) <- checkExpr be2
  case (t1 == t2) && (t1 == Tbool) of
    True -> return (Tbool, Undefined)
    False -> throwError $ "Unsupported operand type(s) for or: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
    
checkExpr (Eland be1 be2) = do
  (t1, _) <- checkExpr be1
  (t2, _) <- checkExpr be2
  case (t1 == t2) && (t1 == Tbool) of
    True -> return (Tbool, Undefined)
    False -> throwError $ "Unsupported operand type(s) for and: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
    
checkExpr (Eeq e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tbool, Undefined)
    False -> throwError $ "Unsupported operand type(s) for ==: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
checkExpr (Eneq e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tbool, Undefined)
    False -> throwError $ "Unsupported operand type(s) for !=: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
checkExpr (Elthen e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tbool, Undefined)
    False -> throwError $ "Unsupported operand type(s) for <: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
checkExpr (Ele e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tbool, Undefined)
    False -> throwError $ "Unsupported operand type(s) for <=: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
checkExpr (Egrthen e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tbool, Undefined)
    False -> throwError $ "Unsupported operand type(s) for >: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 
checkExpr (Ege e1 e2) = do
  (t1, _) <- checkExpr e1
  (t2, _) <- checkExpr e2
  case (t1 == t2) && (t1 == Tint) of
    True -> return (Tbool, Undefined)
    False -> throwError $ "Unsupported operand type(s) for >=: '" ++ (show t1) ++ "' and '" ++ (show t2) ++ "'." 

checkExpr (Epreoplog Logicalneg be) = do
  (t, _) <- checkExpr be
  case t of 
    Tbool -> return (Tbool, Undefined)
    otherwise -> throwError $ "Unsupported operand type for not: '" ++ (show t) ++ "'." 

checkExpr (Epreopexp op e) = do
  (t, _) <- checkExpr e
  case t of
    Tint -> return (Tint, Undefined)
    otherwise -> case op of 
      Plus -> throwError $ "Unsupported operand type for unary +: '" ++ (show t) ++ "'." 
      Negative -> throwError $ "Unsupported operand type for unary -: '" ++ (show t) ++ "'."
      
checkExpr (Earray []) = return (Tarray Tany, Undefined)
checkExpr (Earray (e:es)) = do
  (headType, _) <- checkExpr e
  (tailType, _) <- checkExpr $ Earray es
  case tailType of 
    (Tarray tailInnerType) -> do
      case headType == tailInnerType || tailInnerType == Tany of
        True -> return (Tarray headType, Undefined)
        False -> throwError "Array types mismatch." 
    
checkExpr (Earrayget arrExp indExp) = do
  (t, _) <- checkExpr indExp
  case t of 
    Tint -> do
      (arrType, _) <- checkExpr arrExp
      case arrType of 
        (Tarray innerType) -> return (innerType, Undefined)
        otherwise -> throwError $ "Unsupported operand type for []: '" ++ (show arrType) ++ "'."
    otherwise -> throwError $ "Unsupported indices type: '" ++ (show t) ++ "'."

checkExpr (Earrgetcom arrExp inds) = do
  (arrType, _) <- checkExpr arrExp
  innerType <- getArrType arrType inds
  return (innerType, Undefined)
  
checkExpr (Epostinc e) = do
  (t, _) <- checkExpr e
  case t of 
    Tint -> return (Tint, Undefined)
    otherwise -> throwError $ "Unsupported operand type for ++ (post increment): '" ++ (show t) ++ "'."
checkExpr (Epostdec e) = do
  (t, _) <- checkExpr e
  case t of 
    Tint -> return (Tint, Undefined)
    otherwise -> throwError $ "Unsupported operand type for ++ (post decrement): '" ++ (show t) ++ "'."
    
checkExpr (Efunkpar fnExpr paramsExpr) = do
  (fnType, _) <- checkExpr fnExpr
  case fnType of 
    (Tfunarg _ _) -> do
      reversedParamsTypes <- getParamsTypes paramsExpr []
      paramsTypes <- return $ reverse $ reversedParamsTypes
      returnType <- checkFunArgs fnType paramsTypes
      return (returnType, Undefined)
    otherwise -> throwError $ "'" ++ (show fnType) ++ "' object is not callable."

checkExpr _ = throwError $ "Unexpected error occurred during type check."

checkConst :: Constant -> PartialResult TypedVal
checkConst (Einteger  int) = return (Tint, Undefined)
checkConst (Estring str) = return (Tstring, Undefined)
checkConst _ = return (Tbool, Undefined)

checkVar :: Ident -> PartialResult TypedVal
checkVar ident = do
  loc <- getloc (Evar ident)
  (t, _) <- getTypeOnly loc
  return (t, Undefined)
  
getParamsTypes :: [Exp] -> [Type] -> PartialResult [Type]
getParamsTypes [] parsedTypes = return parsedTypes
getParamsTypes (paramExpr:paramsExprs) parsedTypes = do 
  (t, _) <- checkExpr paramExpr  
  getParamsTypes paramsExprs (t:parsedTypes)

  
