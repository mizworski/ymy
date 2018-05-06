module Interpreter where


import Datatypes
import TypeCheck
import ExprEvaluation
import Memory

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
      putStrLn $ show program
      res <- runExceptT $ runProg env store program
      case res of
        (Left e) -> do
          hPutStrLn stderr $ "Runtime error: " ++ e
          return (env, store)
        (Right (env', store')) -> do
          putStrLn $ show env'
          putStrLn $ show store'
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

runDecl :: Decl_stmt -> PartialResult Env
runDecl (DeclVar (Declarator identifier varType)) = declare identifier varType

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

evalIterStmt :: Iter_stmt -> PartialResult TypedVal
evalIterStmt (Swhile condExp stmt) = evalWhile condExp stmt
evalIterStmt (Sfor initExpStmt condExpStmt incrExp evalStmt) = evalFor initExpStmt condExpStmt incrExp evalStmt
evalIterStmt (Sfornoinc initExpStmt condExpStmt evalStmt) = evalFor initExpStmt condExpStmt (Econst $ Einteger 0) evalStmt

evalWhile :: Exp -> Stmt -> PartialResult TypedVal
evalWhile condExp stmt = do
  (varType, val) <- evalExpr condExp
  case val of
    Boolean True -> do
      res <- evalStmt stmt
      evalWhile condExp stmt
      return (Tunit, Undefined)
    Boolean False -> do
      return (Tunit, Undefined)
    otherwise -> throwError "Condition must be bexpr."

evalFor :: Expression_stmt -> Expression_stmt -> Exp -> Stmt -> PartialResult TypedVal
evalFor initExpStmt (Sexpr condExp) incrExp evalStmt = do
  res <- evalExprStmt initExpStmt
  evalWhile condExp $ CompS $ Scomp $ evalStmt : (ExprS $ Sexpr incrExp) : []


evalSelStmt :: Selection_stmt -> PartialResult TypedVal
evalSelStmt (Sif condExp stmt) = evalIfElse condExp stmt $ ExprS $ SexprEmpty
evalSelStmt (SifElse condExp stmtTrue stmtFalse) = evalIfElse condExp stmtTrue stmtFalse

evalIfElse :: Exp -> Stmt -> Stmt -> PartialResult TypedVal
evalIfElse condExp stmtTrue stmtFalse = do
  (varType, val) <- evalExpr condExp
  case val of
    Boolean True -> do
      res <- evalStmt stmtTrue
      return (Tunit, Undefined)
    Boolean False -> do
      res <- evalStmt stmtFalse
      return (Tunit, Undefined)
    otherwise -> throwError "Condition must be bexpr."

evalFlowStmt :: Flow_stmt -> PartialResult TypedVal
evalFlowStmt stmt = return (Tint, Num 0)

evalPrintStmt :: Print_stmt -> PartialResult TypedVal
evalPrintStmt (Sprint exp) = do
  (varType, val) <- evalExpr exp
  lift $ lift $ lift $ putStrLn $ show val
  return (varType, val)
