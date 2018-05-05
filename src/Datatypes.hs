module Datatypes where

import AbsYmyLang

import Data.Map
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Except

--type Var = String
type Loc = Int
type TypedVal = (Type, Val)

type Env = [(Ident, Loc)]

type Result = ExceptT String IO

--data VarType
--  = IntT
--  | BoolT
--  | StringT
--  | UnitT

--instance Eq VarType where
--     IntT == IntT = True
--     BoolT == BoolT = True
--     StringT == StringT = True
--     UnitT == UnitT = True
--
--instance Show VarType where
--    show (IntT) = "Int"
--    show (BoolT) = "Bool"
--    show (StringT) = "Char"
--    show (UnitT) = "()"

data Val
  = Num Int
  | Bool Bool
  | String String
  | Undefined
  deriving (Show)

type Store = Data.Map.Map Loc TypedVal

-- moge w ogole dodac Show Store? probowalem ale nie udalo mi sie

showStore :: Store -> String
showStore store = do
  Data.Map.foldr (\tval acc -> ((show tval) ++ "\n" ++ acc)) "" store

type PartialResult a = StateT Store (ReaderT Env Result) a
