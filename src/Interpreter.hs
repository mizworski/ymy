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


interpret :: Env -> Store -> Program -> Result ((Env, Store))
--interpret env store program = runReaderT (runStateT (runProg program) store) env
interpret env store program = runProg env store program


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


evalStmt :: Stmt -> PartialResult TypedVal
evalStmt stmt = return (Tint, Num 2)


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
overwrite var loc = do
  env <- ask
  return [ if(var1 == var) then (var, loc) else envEl | envEl@(var1 ,loc1) <- env ]

newloc :: PartialResult Loc
newloc = do
  store <- get
  return $ hNewloc 0 store


hNewloc :: Int -> Store -> Int
hNewloc loc store =
  case Data.Map.lookup loc store of
    Nothing -> loc
    otherwise -> hNewloc (loc + 1) store
