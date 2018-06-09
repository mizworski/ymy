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
  --return (env', res)
  
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
checkStmt (ExprS stmt) returnType = checkExprStmt stmt
checkStmt (CompS stmt) returnType = checkCompoundStmt stmt
checkStmt (SelS stmt) returnType = checkSelStmt stmt
checkStmt (IterS stmt) returnType = checkIterStmt stmt
checkStmt (FlowS stmt) returnType = checkFlowStmt stmt
checkStmt (PrintS stmt) returnType = checkPrintStmt stmt

checkExprStmt _ = return $ Right (Tunit, Undefined)
checkCompoundStmt _ = return $ Right (Tunit, Undefined)
checkSelStmt _ = return $ Right (Tunit, Undefined)
checkIterStmt _ = return $ Right (Tunit, Undefined)
checkFlowStmt _ = return $ Right (Tunit, Undefined)
checkPrintStmt _ = return $ Right (Tunit, Undefined)
