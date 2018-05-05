module Datatypes where

import Data.Map
import Control.Monad.Except

type Var = String
type Loc = Int
type TypedVal = (Type, Val)

type Env = [(Var, Loc)]
type Store = Data.Map.Map Loc TypedVal

type Result = ExceptT String IO((Env, Store))

data Type
  = IntT
  | BoolT
  | StringT
  | UnitT

instance Eq Type where
     IntT == IntT = True
     BoolT == BoolT = True
     StringT == StringT = True
     UnitT == UnitT = True

instance Show Type where
    show (IntT) = "Int"
    show (BoolT) = "Bool"
    show (StringT) = "Char"
    show (UnitT) = "()"

data Val
  = Num Int
  | Bool Bool
  | String String
  | Undefined