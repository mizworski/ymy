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
import Control.Monad.Cont

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
      res <- runExceptT $ runProg env store program
      case res of
        (Left e) -> do
           hPutStrLn stderr $ "Runtime error: " ++ e
           return (env, store)
        (Right (env', store')) -> do
           return (env', store')


runProg :: Env -> Store -> Program -> Result ((Env, Store))
runProg env store (Progr []) = return (env, store)


runProg env store (Progr (stmt:stmts)) = do
  ((env', _), store') <- runReaderT (runStateT (runStmt stmt) store) env
  runProg env' store' (Progr stmts)


runStmt :: Stmt -> PartialResult ((Env, FTypedVal))
runStmt (DeclS decl) = do
  env' <- runDecl decl
  return (env', Right (Tunit, Undefined))
runStmt stmt = do
  env' <- ask
  res <- evalStmt stmt
  
  return (env', res)

runDecl :: Decl_stmt -> PartialResult Env
runDecl (DeclVar (Declarator name varType)) = declare name varType
runDecl (DeclFn (Declarator name fnType) args stmt) = defineFun name fnType args stmt

defineFun :: Ident -> Type -> [Dec] -> Stmt -> PartialResult Env
defineFun fnName fnType args stmt = do
  env <- ask
  env1 <- local (const env) $ declare fnName fnType
  let fn params = do
      (env2, _) <- local (const env1) $ parseArgs args params
      (_, res) <- local (const env2) $ runStmt stmt
      case res of
        (Left (FReturn res)) -> return res
        (Left FReturnVoid) -> return (Tunit, Undefined) 
        otherwise -> throwError $ "Function '" ++ (show fnName) ++ "' had no return."

  loc <- local (const env1) $ getloc (Evar fnName)
  store <- get

  case Data.Map.lookup loc store of
    Nothing -> throwError $ "Failed to declare function '" ++ (show fnName) ++ "'." 
    otherwise -> local (const env1) $ modify (Data.Map.insert loc (fnType, Fun fn))

  return env1

evalStmt :: Stmt -> PartialResult FTypedVal
evalStmt (ExprS stmt) = evalExprStmt stmt

evalStmt (CompS stmt) = evalCompoundStmt stmt
evalStmt (SelS stmt) = evalSelStmt stmt
evalStmt (IterS stmt) = evalIterStmt stmt
evalStmt (FlowS stmt) = evalFlowStmt stmt
evalStmt (PrintS stmt) = evalPrintStmt stmt

evalCompoundStmt :: Compound_stmt -> PartialResult FTypedVal
evalCompoundStmt (Scomp []) = return $ Right (Tunit, Undefined)
evalCompoundStmt (Scomp ((DeclS decl):stmts)) = do
  env' <- runDecl decl
  res <- local (const env') (evalCompoundStmt (Scomp stmts))
  return res
evalCompoundStmt (Scomp (stmt:stmts)) = do
  res <- evalStmt stmt
  case res of
    (Left fl) -> return $ Left fl
    otherwise -> do
      res <- evalCompoundStmt (Scomp stmts)
      return res

evalExprStmt :: Expression_stmt -> PartialResult FTypedVal
evalExprStmt SexprEmpty = return $ Right (Tunit, Undefined)
evalExprStmt (Sexpr expr) = do
  res <- evalExpr expr
  return $ Right res

evalIterStmt :: Iter_stmt -> PartialResult FTypedVal
evalIterStmt (Swhile condExp stmt) = evalWhile condExp stmt
evalIterStmt (Sfor initExpStmt condExpStmt incrExp evalStmt) = evalFor initExpStmt condExpStmt incrExp evalStmt
evalIterStmt (Sfornoinc initExpStmt condExpStmt evalStmt) = evalFor initExpStmt condExpStmt (Econst $ Einteger 0) evalStmt

evalWhile :: Exp -> Stmt -> PartialResult FTypedVal
evalWhile condExp stmt = evalLoop condExp (Econst $ Einteger 0) stmt

evalLoop :: Exp -> Exp -> Stmt -> PartialResult FTypedVal
evalLoop condExp postLoopExp stmt = do
  (varType, val) <- evalExpr condExp
  case val of
    Boolean True -> do
      res <- evalStmt stmt
      case res of
        (Left FBreak) -> return $ Right (Tunit, Undefined)
        (Left FReturnVoid) -> return $ Left FReturnVoid
        (Left (FReturn res)) -> return $ Left (FReturn res)
        otherwise -> do
          evalExpr postLoopExp
          evalLoop condExp postLoopExp stmt

      return $ Right (Tunit, Undefined)
    Boolean False -> do
      return $ Right (Tunit, Undefined)
    otherwise -> throwError "Condition must be bexpr."

evalFor :: Expression_stmt -> Expression_stmt -> Exp -> Stmt -> PartialResult FTypedVal
evalFor (Sexpr initExp) (Sexpr condExp) incrExp evalStmt = do
  res <- evalExprStmt $ Sexpr initExp
  evalLoop condExp incrExp evalStmt
evalFor (Sexpr initExp) _ incrExp evalStmt = do
  res <- evalExprStmt $ Sexpr initExp
  evalLoop (Econst Etrue) incrExp evalStmt
evalFor _ (Sexpr condExp) incrExp evalStmt = do
  evalLoop condExp incrExp evalStmt
evalFor _ _ incrExp evalStmt = do
  evalLoop (Econst Etrue) incrExp evalStmt


evalSelStmt :: Selection_stmt -> PartialResult FTypedVal
evalSelStmt (Sif condExp stmt) = evalIfElse condExp stmt $ ExprS $ SexprEmpty
evalSelStmt (SifElse condExp stmtTrue stmtFalse) = evalIfElse condExp stmtTrue stmtFalse

evalIfElse :: Exp -> Stmt -> Stmt -> PartialResult FTypedVal
evalIfElse condExp stmtTrue stmtFalse = do
  (varType, val) <- evalExpr condExp
  case val of
    Boolean True -> do
      res <- evalStmt stmtTrue
      return res
    Boolean False -> do
      res <- evalStmt stmtFalse
      return res
    otherwise -> throwError "Condition must be bexpr."

evalFlowStmt :: Flow_stmt -> PartialResult FTypedVal
evalFlowStmt Scontinue = return $ Left FContinue
evalFlowStmt Sbreak = return $ Left FBreak
evalFlowStmt SreturnVoid = return $ Left FReturnVoid
evalFlowStmt (Sreturn expr) = do
  res <- evalExpr expr
  return $ Left (FReturn res)

evalPrintStmt :: Print_stmt -> PartialResult FTypedVal
evalPrintStmt (Sprint exp) = do
  (_, val) <- evalExpr exp
  (varType, _) <- checkExpr exp
  case varType of 
    (Tfun _ _) -> liftIO $ putStrLn $ show varType
    (Tfunarg _ _) -> liftIO $ putStrLn $ show varType
    othwerwise -> liftIO $ putStrLn $ show val
  return $ Right $ (varType, val)
