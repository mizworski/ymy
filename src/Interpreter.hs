module Interpreter where


import Datatypes
import TypeCheck

import ParYmyLang
import LexYmyLang
import AbsYmyLang
import PrintYmyLang
import ErrM

import qualified Data.Map
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Except

import System.IO
import System.Environment

interpret :: Env -> Store -> Program -> IO((Env, Store))
interpret env store program = do
  checkRes <- runExceptT $ typeCheck env store program
  case checkRes of
    (Left e) -> do
      hPutStrLn stderr $ "Type error: " ++ e
      return (env, store)
    otherwise -> do
--      putStrLn $ show program
      res <- runExceptT $ runProg env store program
      case res of
        (Left e) -> do
          hPutStrLn stderr $ "Runtime error: " ++ e
          return (env, store)
        (Right (env', store')) -> do
--          putStrLn $ show env'
--          putStrLn $ show store'
          return (env', store')


runProg :: Env -> Store -> Program -> Result ((Env, Store))
runProg env store (Progr []) = do
  return (env, store)


runProg env store (Progr (stmt:stmts)) = do
  (env', store') <- runReaderT (runStateT (runStmt stmt) store) env
  runProg env' store' (Progr stmts)


runStmt :: Stmt -> PartialResult Env
runStmt (DeclS decl) = do
  env' <- runDecl decl
  return env'
runStmt stmt = do
  env <- ask
  evalStmt stmt
  return env

runStmts :: [Stmt] -> PartialResult Env
runstmts [] = do
  env <- ask
  return env
runStmts (stmt:stmts) = do
  env <- runStmt stmt
  runStmts stmts

evalStmt :: Stmt -> PartialResult TypedVal
evalStmt (ExprS stmt) = evalExprStmt stmt
evalStmt (CompS stmt) = evalCompoundStmt stmt
evalStmt (SelS stmt) = evalSelStmt stmt
evalStmt (IterS stmt) = evalIterStmt stmt
evalStmt (FlowS stmt) = evalFlowStmt stmt
evalStmt (PrintS stmt) = evalPrintStmt stmt

evalCompoundStmt :: Compound_stmt -> PartialResult TypedVal
evalCompoundStmt (Scomp []) = return (Tunit, Undefined)
evalCompoundStmt (Scomp ((DeclS decl):stmts)) = do
  env' <- runDecl decl
  local (const env') (evalCompoundStmt (Scomp stmts))
  return (Tunit, Undefined)
evalCompoundStmt (Scomp (stmt:stmts)) = do
  evalStmt stmt
  evalCompoundStmt (Scomp stmts)
  return (Tunit, Undefined)

evalExprStmt :: Expression_stmt -> PartialResult TypedVal
evalExprStmt SexprEmpty = return (Tunit, Undefined)
evalExprStmt (Sexpr expr) = evalExpr expr

evalExpr :: Exp -> PartialResult TypedVal
evalExpr (Eassign e1 op e2) = do
  newVal <- case op of
    Assign -> evalExpr e2
    AssignMul -> evalExpr $ Etimes e1 e2
    AssignDiv -> evalExpr $ Ediv e1 e2
    AssignMod -> evalExpr $ Emod e1 e2
    AssignAdd -> evalExpr $ Eplus e1 e2
    AssignSub -> evalExpr $ Eminus e1 e2
  assign e1 newVal
  return newVal

evalExpr (Econdition be e1 e2) = do
  (Tbool, Boolean b) <- evalExpr be
  case b of
    True -> do
      res <- evalExpr e1
      return res
      -- dlaczego nie moge zrobic return evalExpr e1?
    False -> do
      res <- evalExpr e2
      return res

evalExpr (Econst const) = evalConst const
evalExpr (Evar ident) = evalVar ident
evalExpr (Eplus e1 e2) = evalBinOpInt e1 e2 (+)
evalExpr (Eminus e1 e2) = evalBinOpInt e1 e2 (-)
evalExpr (Etimes e1 e2) = evalBinOpInt e1 e2 (*)
evalExpr (Ediv e1 e2) = do
  (Tint, Num v1) <- evalExpr e1
  (Tint, Num v2) <- evalExpr e2
  case v2 of
    0 -> throwError "Division by zero."
    otherwise -> return $ (Tint, Num $ v1 `div` v2)
evalExpr (Emod e1 e2) = do
  (Tint, Num v1) <- evalExpr e1
  (Tint, Num v2) <- evalExpr e2
  case v2 of
    0 -> throwError "Modulo by zero."
    otherwise -> return $ (Tint, Num $ v1 `mod` v2)

evalExpr (Elor be1 be2) = evalBinOpBool be1 be2 (||)
evalExpr (Eland be1 be2) = evalBinOpBool be1 be2 (&&)
evalExpr (Eeq e1 e2) = evalBinOpIntBool e1 e2 (==)
evalExpr (Eneq e1 e2) = evalBinOpIntBool e1 e2 (/=)
evalExpr (Elthen e1 e2) = evalBinOpIntBool e1 e2 (<)
evalExpr (Ele e1 e2) = evalBinOpIntBool e1 e2 (<=)
evalExpr (Egrthen e1 e2) = evalBinOpIntBool e1 e2 (>)
evalExpr (Ege e1 e2) = evalBinOpIntBool e1 e2 (>=)

evalConst :: Constant -> PartialResult TypedVal
evalConst (Einteger  int) = return (Tint, Num int)
evalConst (Estring str) = return (Tstring, Str str)
evalConst boolean =
  case boolean of
    Etrue -> return (Tbool, Boolean True)
    Efalse -> return (Tbool, Boolean False)

evalVar :: Ident -> PartialResult TypedVal
evalVar ident = do
  loc <- getloc (Evar ident)
  getval loc

evalBinOpInt :: Exp -> Exp -> (Integer -> Integer -> Integer) -> PartialResult TypedVal
evalBinOpInt e1 e2 op = do
  (Tint, Num v1) <- evalExpr e1
  (Tint, Num v2) <- evalExpr e2
  return $ (Tint, Num $ op v1 v2)

evalBinOpBool :: Exp -> Exp -> (Bool -> Bool -> Bool) -> PartialResult TypedVal
evalBinOpBool e1 e2 op = do
  (Tbool, Boolean v1) <- evalExpr e1
  (Tbool, Boolean v2) <- evalExpr e2
  return $ (Tbool, Boolean $ op v1 v2)

evalBinOpIntBool :: Exp -> Exp -> (Integer -> Integer -> Bool) -> PartialResult TypedVal
evalBinOpIntBool e1 e2 op = do
  (Tint, Num v1) <- evalExpr e1
  (Tint, Num v2) <- evalExpr e2
  return $ (Tbool, Boolean $ op v1 v2)

evalIterStmt :: Iter_stmt -> PartialResult TypedVal
evalIterStmt stmt = return (Tint, Num 0)

evalSelStmt :: Selection_stmt -> PartialResult TypedVal
evalSelStmt stmt = return (Tint, Num 0)

evalFlowStmt :: Flow_stmt -> PartialResult TypedVal
evalFlowStmt stmt = return (Tint, Num 0)

evalPrintStmt :: Print_stmt -> PartialResult TypedVal
evalPrintStmt (Sprint exp) = do
  (varType, val) <- evalExpr exp
  lift $ lift $ lift $ putStrLn $ show val
  return (varType, val)

runDecl :: Decl_stmt -> PartialResult Env
runDecl (DeclVar (Declarator identifier varType)) = declare identifier varType


declare :: Ident -> Type -> PartialResult Env
declare varName varType = do
  env <- ask
  loc <- newloc
  modify $ Data.Map.insert loc (varType, Undefined)
  case lookup varName env of
    Nothing -> return $ (varName, loc) : env
    Just val -> overwrite varName loc

overwrite :: Ident -> Loc -> PartialResult Env
overwrite var newloc = do
  env <- ask
  return [ if(envVar == var) then (var, newloc) else envElem | envElem@(envVar, envLoc) <- env ]

newloc :: PartialResult Loc
newloc = do
  store <- get
  return $ hNewloc 0 store


hNewloc :: Int -> Store -> Int
hNewloc loc store =
  case Data.Map.lookup loc store of
    Nothing -> loc
    otherwise -> hNewloc (loc + 1) store

assign :: Exp -> TypedVal -> PartialResult ()
assign lvalue typedVal = do
  loc <- getloc lvalue
  val <- deepCopy typedVal
  modify $ Data.Map.insert loc typedVal


getloc :: Exp -> PartialResult Loc
getloc (Evar ident) = do
  env <- ask
  case lookup ident env of
    Nothing -> throwError "Undeclared var."
    Just loc -> return loc

getval :: Loc -> PartialResult TypedVal
getval loc = do
  store <- get
  case Data.Map.lookup loc store of
    Nothing -> throwError $ "Internal Error - invalid loc: " ++ show loc
    Just (_, Undefined) -> throwError $ "Undefinded var at loc: " ++ show loc
    Just val -> return val
deepCopy :: TypedVal -> PartialResult TypedVal
deepCopy val = return val