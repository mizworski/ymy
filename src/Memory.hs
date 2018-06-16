module Memory where

import Datatypes

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

getloc :: Exp -> PartialResult Loc
getloc (Evar ident) = do
  env <- ask
  case lookup ident env of
    Nothing -> throwError $ "Undeclared variable: " ++ show ident
    Just loc -> return loc

getloc (Earrayget lvalue ind) = getloc lvalue

getval :: Loc -> PartialResult TypedVal
getval loc = do
  store <- get
  case Data.Map.lookup loc store of
    Nothing -> throwError $ "Internal Error - invalid loc: " ++ show loc
    Just (_, Undefined) -> do
      env <- ask
      varName <- findVarName loc env
      throwError $ "Undefinded variable: " ++ show varName
    Just val -> return val

findVarName :: Loc -> Env -> PartialResult Ident
findVarName loc ((varIdent, varLoc):vars) = do 
  case loc == varLoc of 
    True -> return varIdent
    False -> findVarName loc vars

getTypeOnly :: Loc -> PartialResult TypedVal
getTypeOnly loc = do
  store <- get
  case Data.Map.lookup loc store of
    Nothing -> throwError $ "Internal Error - invalid loc: " ++ show loc
    Just val -> return val


deepCopy :: TypedVal -> PartialResult TypedVal
deepCopy val = return val


getArrType :: Type -> [Exp] -> PartialResult Type
getArrType arrType [] = return arrType
getArrType (Tarray innerType) (ind:inds) = getArrType innerType inds
getArrType _ _ = throwError $ "Array rank is too small. Too many indices."
