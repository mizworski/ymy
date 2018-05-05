module TypeCheck where

import Datatypes

import ParYmyLang
import LexYmyLang
import AbsYmyLang
import PrintYmyLang
import ErrM

import Control.Monad.Reader
import Control.Monad.Except
import Control.Monad.Identity
import Data.Map

type TypeCheckResult = ExceptT String IO

typeCheck :: Program -> TypeCheckResult ()
typeCheck p = do
--  runReaderT (checkProgram p) (empty, empty, empty)
  return ()
