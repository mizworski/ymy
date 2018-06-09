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
  env <- ask
  returnType <- checkFunArgs fnType args
  checkStmt stmt returnType
  env1 <- local (const env) $ declare fnName fnType
  loc <- local (const env1) $ getloc (Evar fnName)
  store <- get

  case Data.Map.lookup loc store of
    Nothing -> throwError "Failed to declare Function."
    otherwise -> local (const env1) $ modify (Data.Map.insert loc (fnType, Undefined))

  return env1

checkFunArgs :: Type -> [Dec] -> PartialResult Type  
checkFunArgs (Tfunarg Tunit fnTypeResult) [] = do
  case fnTypeResult of
    (Tfunarg _ _) -> throwError "Cannot take arguments after found Unit in declaration."
    otherwise -> return fnTypeResult
checkFunArgs (Tfunarg _ _) [] = throwError "Invalid number of arguments passed to function."
checkFunArgs fnType [] = return fnType 

checkFunArgs (Tfunarg argDeclType fnTypeResult) ((Declarator _ argActualType):args) = do
  case argDeclType == argActualType of
    True -> checkFunArgs fnTypeResult args
    otherwise -> case argDeclType of 
      (Tfun firstArg resType) -> do 
        case (Tfunarg firstArg resType) == argActualType of
          True -> checkFunArgs fnTypeResult args
          False -> throwError "Argument type is invalid."
    
checkFunArgs _ _ = throwError "Function argument checking failed."

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
checkExpr expr = return (Tunit, Undefined)

