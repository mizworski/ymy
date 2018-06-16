module Datatypes where

import AbsYmyLang


import Data.Map
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Except

type Loc = Int
type TypedVal = (Type, Val)
type FTypedVal = Either Flow TypedVal
type FType = Either Flow Type

type Env = [(Ident, Loc)]

--type Result = ExceptT String (ExceptT Flow IO)
type Result = ExceptT String IO

--type Function = (Env, [Ident], Stmt)
type Funct = [TypedVal] -> PartialResult TypedVal
--newtype IFun = IFun ([TypedVal] -> PartialResult TypedVal)
data Flow
  = FBreak
  | FContinue
  | FReturnVoid
  | FReturn TypedVal

instance Show Flow where
  show FBreak = "Break"
  show FContinue = "Continue"
  show (FReturn val) = show val

data Val
  = Num Integer
  | Boolean Bool
  | Str String
  | Fun Funct
  | Arr [Val]
  | Undefined

instance Show Val where
  show Undefined = "Undefined"
  show (Fun fn) = "Function"
  show (Num n) = show n
  show (Boolean b) = show b
  show (Str str) = str
  show (Arr xs) = show xs

type Store = Data.Map.Map Loc TypedVal

-- moge w ogole dodac Show Store? probowalem ale nie udalo mi sie

showStore :: Store -> String
showStore store = do
  Data.Map.foldr (\tval acc -> ((show tval) ++ "\n" ++ acc)) "" store

type PartialResult a = StateT Store (ReaderT Env Result) a
