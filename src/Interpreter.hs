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

-- nie musze przekazywac enva breakow, continue, returnow, bo kazda definicja funkcji, petla jest wczytywana na raz
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
    --          putStrLn $ showStore store'
           return (env', store')


runProg :: Env -> Store -> Program -> Result ((Env, Store))
runProg env store (Progr []) = return (env, store)


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
runDecl (DeclVar (Declarator name varType)) = declare name varType
runDecl (DeclFn (Declarator name fnType) args stmt) = defineFun name fnType args stmt

-- jakby zamienic Val na Bexpr to mamy call by name vs call by value
parseBindArguments :: [Dec] -> [TypedVal] -> PartialResult (Env, [Ident])
parseBindArguments [] [] = do
  env <- ask
  return (env, [])

parseBindArguments ((Declarator ident paramType):vars) (val:vals) = do
    env <- ask
    env1 <- local (const env) $ declare ident paramType
    local (const env1) $ assign (Evar ident) val
    (env2, acc) <- local (const env1) $ parseBindArguments vars vals
    return (env2, ident : acc)

defineFun :: Ident -> Type -> [Dec] -> Stmt -> PartialResult Env
defineFun fnName fnType args stmt = do
  env <- ask
  env1 <- local (const env) $ declare fnName fnType
  let fname params = do
      (env2, params) <- local (const env1) $ parseBindArguments args params
      env3 <- local (const env2) $ runStmt stmt

      -- todo return values
      return (Tunit, Undefined)

  loc <- local (const env1) $ getloc (Evar fnName)
  store <- get

  case Data.Map.lookup loc store of
    Nothing -> throwError "Failed to declare Function."
    otherwise -> local (const env1) $ modify (Data.Map.insert loc (fnType, Fun fname))

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
        (Left (FReturn res)) -> return $ Left (FReturn res)
        otherwise -> do
          evalExpr postLoopExp
          evalLoop condExp postLoopExp stmt

      return $ Right (Tunit, Undefined)
    Boolean False -> do
      return $ Right (Tunit, Undefined)
    otherwise -> throwError "Condition must be bexpr."

evalFor :: Expression_stmt -> Expression_stmt -> Exp -> Stmt -> PartialResult FTypedVal
evalFor initExpStmt (Sexpr condExp) incrExp evalStmt = do
  res <- evalExprStmt initExpStmt
  evalLoop condExp incrExp evalStmt
evalFor initExpStmt empty incrExp evalStmt = do
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
evalFlowStmt (Sreturn expr) = do
  res <- evalExpr expr
  return $ Left (FReturn res)

evalPrintStmt :: Print_stmt -> PartialResult FTypedVal
evalPrintStmt (Sprint exp) = do
  (varType, val) <- evalExpr exp
  liftIO $ putStrLn $ show val
  return $ Right $ (varType, val)
