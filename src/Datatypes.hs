module Datatypes where

import AbsYmyLang

import Data.Map
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Except

type Loc = Int
type TypedVal = (Type, Val)

type Env = [(Ident, Loc)]

type Result = ExceptT String IO

type Function = (Env, [Ident], Stmt)

data Val
  = Num Integer
  | Boolean Bool
  | Str String
  | Fun Function
  | Undefined

instance Show Val where
  show (Num n) = show n
  show (Boolean b) = show b
  show (Str str) = str
  show (Fun fn) = show fn
  show Undefined = "Undefined"

type Store = Data.Map.Map Loc TypedVal

-- moge w ogole dodac Show Store? probowalem ale nie udalo mi sie

showStore :: Store -> String
showStore store = do
  Data.Map.foldr (\tval acc -> ((show tval) ++ "\n" ++ acc)) "" store

type PartialResult a = StateT Store (ReaderT Env Result) a
