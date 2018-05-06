module ExprEvaluation where

import Datatypes
import TypeCheck
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

import System.IO
import System.Environment

evalExpr :: Exp -> PartialResult TypedVal
evalExpr (Eassign e1 op e2) = do
  newVal <- case op of
    Assign -> evalExpr e2
    AssignMul -> evalExpr $ Etimes e1 e2
    AssignDiv -> evalExpr $ Ediv e1 e2
    AssignMod -> evalExpr $ Emod e1 e2
    AssignAdd -> evalExpr $ Eplus e1 e2
    AssignSub -> evalExpr $ Eminus e1 e2
  assign e1 newVal
  return newVal

evalExpr (Econdition be e1 e2) = do
  (Tbool, Boolean b) <- evalExpr be
  case b of
    True -> do
      res <- evalExpr e1
      return res
      -- dlaczego nie moge zrobic return evalExpr e1?
    False -> do
      res <- evalExpr e2
      return res

evalExpr (Econst const) = evalConst const
evalExpr (Evar ident) = evalVar ident
evalExpr (Eplus e1 e2) = evalBinOpInt e1 e2 (+)
evalExpr (Eminus e1 e2) = evalBinOpInt e1 e2 (-)
evalExpr (Etimes e1 e2) = evalBinOpInt e1 e2 (*)
evalExpr (Ediv e1 e2) = do
  (Tint, Num v1) <- evalExpr e1
  (Tint, Num v2) <- evalExpr e2
  case v2 of
    0 -> throwError "Division by zero."
    otherwise -> return $ (Tint, Num $ v1 `div` v2)
evalExpr (Emod e1 e2) = do
  (Tint, Num v1) <- evalExpr e1
  (Tint, Num v2) <- evalExpr e2
  case v2 of
    0 -> throwError "Modulo by zero."
    otherwise -> return $ (Tint, Num $ v1 `mod` v2)

evalExpr (Elor be1 be2) = evalBinOpBool be1 be2 (||)
evalExpr (Eland be1 be2) = evalBinOpBool be1 be2 (&&)
evalExpr (Eeq e1 e2) = evalBinOpIntBool e1 e2 (==)
evalExpr (Eneq e1 e2) = evalBinOpIntBool e1 e2 (/=)
evalExpr (Elthen e1 e2) = evalBinOpIntBool e1 e2 (<)
evalExpr (Ele e1 e2) = evalBinOpIntBool e1 e2 (<=)
evalExpr (Egrthen e1 e2) = evalBinOpIntBool e1 e2 (>)
evalExpr (Ege e1 e2) = evalBinOpIntBool e1 e2 (>=)

evalExpr (Epreoplog Logicalneg be) = do
  (Tbool, Boolean b) <- evalExpr be
  return (Tbool, Boolean $ not b)

evalExpr (Epreopexp op e) = do
  (Tint, Num v) <- evalExpr e
  case op of
    Plus -> return (Tint, Num v)
    Negative -> return (Tint, Num $ -v)

evalExpr (Epostinc e) = do
  (Tint, Num v) <- evalExpr e
  assign e (Tint, Num $ v + 1)
  return (Tint, Num v)
evalExpr (Epostdec e) = do
  (Tint, Num v) <- evalExpr e
  assign e (Tint, Num $ v - 1)
  return (Tint, Num v)

evalConst :: Constant -> PartialResult TypedVal
evalConst (Einteger  int) = return (Tint, Num int)
evalConst (Estring str) = return (Tstring, Str str)
evalConst boolean =
  case boolean of
    Etrue -> return (Tbool, Boolean True)
    Efalse -> return (Tbool, Boolean False)

evalVar :: Ident -> PartialResult TypedVal
evalVar ident = do
  loc <- getloc (Evar ident)
  getval loc

evalBinOpInt :: Exp -> Exp -> (Integer -> Integer -> Integer) -> PartialResult TypedVal
evalBinOpInt e1 e2 op = do
  (Tint, Num v1) <- evalExpr e1
  (Tint, Num v2) <- evalExpr e2
  return $ (Tint, Num $ op v1 v2)

evalBinOpBool :: Exp -> Exp -> (Bool -> Bool -> Bool) -> PartialResult TypedVal
evalBinOpBool e1 e2 op = do
  (Tbool, Boolean v1) <- evalExpr e1
  (Tbool, Boolean v2) <- evalExpr e2
  return $ (Tbool, Boolean $ op v1 v2)

evalBinOpIntBool :: Exp -> Exp -> (Integer -> Integer -> Bool) -> PartialResult TypedVal
evalBinOpIntBool e1 e2 op = do
  (Tint, Num v1) <- evalExpr e1
  (Tint, Num v2) <- evalExpr e2
  return $ (Tbool, Boolean $ op v1 v2)