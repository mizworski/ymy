module Memory where

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