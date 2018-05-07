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
  -- todo check types
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
evalExpr (Eplus e1 e2) = do
    (t1, v1) <- evalExpr e1
    (t2, v2) <- evalExpr e2
    case t1 == t2 of
      True -> do
        case t1 of
          -- to odpakowywanie jest jakims koszmarem, ale musialem tak zrobic aby uniknac dwukrotnej ewaliacji expra
          -- moge to zrobic jakos inaczej?
          Tint -> return $ (Tint, Num $ (+) ((\(Num x) -> x) v1) ((\(Num x) -> x) v2))
          (Tarray _) -> return $ (t1, Arr $ ((\(Arr xs) -> xs) v1) ++ (((\(Arr xs) -> xs) v2)))
      False -> throwError "Invalid types1."

-- to tez wyglada okropnie
evalExpr (Etimes e1 e2) = do
    (t1, v1) <- evalExpr e1
    (t2, v2) <- evalExpr e2
    case t1 == t2 of
      True -> do
        case t1 of
          Tint -> return $ (Tint, Num $ (+) ((\(Num x) -> x) v1) ((\(Num x) -> x) v2))
          otherwise -> throwError "Invalid types2."
      False -> do
        case t1 of
          (Tarray _) -> return $ (t1, Arr $ duplicateArr ((\(Arr xs) -> xs) v1) (((\(Num x) -> x) v2)) [])
          otherwise -> do
            case t2 of
              (Tarray _) -> return $ (t2, Arr $ duplicateArr ((\(Arr xs) -> xs) v2) (((\(Num x) -> x) v1)) [])
              otherwise -> throwError "Invalid types3."

evalExpr (Eminus e1 e2) = evalBinOpInt e1 e2 (-)
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

evalExpr (Earray []) = return (Tarray Tany, Arr [])
evalExpr (Earray (e:es)) = do
  (headType, headVal) <- evalExpr e
  (Tarray tailType, Arr tailVal) <- evalExpr $ Earray es
  case headType == tailType || tailType == Tany of
    True -> return (Tarray headType, Arr (headVal:tailVal))
    False -> throwError "Array types mismatch."


evalExpr (Earrgetcom arrExp indices) = do
  (Tarray elType, Arr arr) <- evalExpr arrExp
  res <- hArrComma arr indices
  return $ (Tarray elType, res)

evalExpr (Earrayget arrExp indExp) = do
  (Tint, Num ind)<- evalExpr indExp
  (Tarray elType, Arr arr) <- evalExpr arrExp
  case compare (toInteger $ length arr) ind of
    GT -> return (elType, arr !! (fromIntegral ind))
    otherwise -> throwError "Index out of range."

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

multiplyArray :: [Exp] -> Exp -> PartialResult TypedVal
multiplyArray a e = do
  (Tint, Num mul) <- evalExpr e
  (Tarray aType, Arr xs) <- evalExpr $ Earray a
  return (Tarray aType, Arr $ duplicateArr xs mul [])

duplicateArr :: [a] -> Integer -> [a] -> [a]
duplicateArr arr 0 acc = acc
duplicateArr arr mul acc = duplicateArr arr (mul - 1) (arr ++ acc)


assign :: Exp -> TypedVal -> PartialResult ()
assign (Evar ident) typedVal = do
  loc <- getloc $ Evar ident
  val <- deepCopy typedVal
  modify $ Data.Map.insert loc typedVal

assign (Earrgetcom lvalue (idExpr:[])) val = assign (Earrayget lvalue idExpr) val
assign (Earrgetcom lvalue (idExpr:idExprs)) val = assign (Earrgetcom (Earrayget lvalue idExpr) idExprs) val

assign (Earrayget lvalue ind) (valType, assignVal) = do
  loc <- getloc $ Earrayget lvalue ind
  (Tarray arrType, Arr oldArr) <- getArray $ Earrayget lvalue ind
  reversed_indices <- getIndices $ Earrayget lvalue ind
  indices <- return $ reverse reversed_indices
  newArr <- modifyArray indices (oldArr) assignVal
  modify $ Data.Map.insert loc (Tarray arrType, newArr)

modifyArray :: [Integer] -> [Val] -> Val -> PartialResult Val

modifyArray (id:[]) oldArray newVal = do
  (ls, _:rs) <- return $ splitAt (fromIntegral id) oldArray
  return $ Arr $ ls ++ newVal : rs

modifyArray (id:indices) oldArray newVal = do
  (ls, (Arr subArr):rs) <- return $ splitAt (fromIntegral id) oldArray
  modifiedSubArray <- modifyArray indices subArr newVal
  return $ Arr $ ls ++ modifiedSubArray : rs

getArray :: Exp -> PartialResult TypedVal
getArray (Earrayget lvalue ind) = getArray lvalue
getArray arrName = evalExpr arrName

getIndices :: Exp -> PartialResult [Integer]
getIndices (Earrayget lvalue indExpr) = do
  (Tint, Num ind) <- evalExpr indExpr
  indices <- getIndices lvalue
  return $ ind : indices
getIndices arrName = return []


hArrComma :: [Val] -> [Exp] -> PartialResult Val
hArrComma arr (idExpr:[]) = do
  (Tint, Num id) <- evalExpr idExpr
  case compare (toInteger $ length arr) id of
    GT -> return $ arr !! (fromIntegral id)
    otherwise -> throwError "Index out of range."

hArrComma arr (idExpr:idExprs) = do
  (Tint, Num id) <- evalExpr idExpr
  case compare (toInteger $ length arr) id of
    GT -> hArrComma ((\(Arr arr) -> arr) (arr !! (fromIntegral id))) idExprs
    otherwise -> throwError "Index out of range."
