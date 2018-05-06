{-# LANGUAGE FlexibleInstances, OverlappingInstances #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns #-}

-- | Pretty-printer for PrintYmyLang.
--   Generated by the BNF converter.

module PrintYmyLang where

import AbsYmyLang
import Data.Char

-- | The top-level printing method.

printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 (map ($ "") $ d []) "" where
  rend i ss = case ss of
    "["      :ts -> showChar '[' . rend i ts
    "("      :ts -> showChar '(' . rend i ts
    "{"      :ts -> showChar '{' . new (i+1) . rend (i+1) ts
    "}" : ";":ts -> new (i-1) . space "}" . showChar ';' . new (i-1) . rend (i-1) ts
    "}"      :ts -> new (i-1) . showChar '}' . new (i-1) . rend (i-1) ts
    ";"      :ts -> showChar ';' . new i . rend i ts
    t  : ts@(p:_) | closingOrPunctuation p -> showString t . rend i ts
    t        :ts -> space t . rend i ts
    _            -> id
  new i   = showChar '\n' . replicateS (2*i) (showChar ' ') . dropWhile isSpace
  space t = showString t . (\s -> if null s then "" else ' ':s)

  closingOrPunctuation :: String -> Bool
  closingOrPunctuation [c] = c `elem` closerOrPunct
  closingOrPunctuation _   = False

  closerOrPunct :: String
  closerOrPunct = ")],;"

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- | The printer class does the job.

class Print a where
  prt :: Int -> a -> Doc
  prtList :: Int -> [a] -> Doc
  prtList i = concatD . map (prt i)

instance Print a => Print [a] where
  prt = prtList

instance Print Char where
  prt _ s = doc (showChar '\'' . mkEsc '\'' s . showChar '\'')
  prtList _ s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q s = case s of
  _ | s == q -> showChar '\\' . showChar s
  '\\'-> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  _ -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j < i then parenth else id

instance Print Integer where
  prt _ x = doc (shows x)

instance Print Double where
  prt _ x = doc (shows x)

instance Print Ident where
  prt _ (Ident i) = doc (showString i)
  prtList _ [] = concatD []
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print Program where
  prt i e = case e of
    Progr stmts -> prPrec i 0 (concatD [prt 0 stmts])

instance Print Stmt where
  prt i e = case e of
    DeclS declstmt -> prPrec i 0 (concatD [prt 0 declstmt])
    CompS compoundstmt -> prPrec i 0 (concatD [prt 0 compoundstmt])
    ExprS expressionstmt -> prPrec i 0 (concatD [prt 0 expressionstmt])
    SelS selectionstmt -> prPrec i 0 (concatD [prt 0 selectionstmt])
    IterS iterstmt -> prPrec i 0 (concatD [prt 0 iterstmt])
    FlowS flowstmt -> prPrec i 0 (concatD [prt 0 flowstmt])
    PrintS printstmt -> prPrec i 0 (concatD [prt 0 printstmt])
  prtList _ [] = concatD []
  prtList _ (x:xs) = concatD [prt 0 x, prt 0 xs]

instance Print [Stmt] where
  prt = prtList

instance Print Dec where
  prt i e = case e of
    Declarator id type_ -> prPrec i 0 (concatD [prt 0 id, doc (showString "::"), prt 2 type_])
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print [Dec] where
  prt = prtList

instance Print Type where
  prt i e = case e of
    Tunit -> prPrec i 0 (concatD [doc (showString "Unit")])
    Tarray type_ -> prPrec i 2 (concatD [doc (showString "["), prt 2 type_, doc (showString "]")])
    Tint -> prPrec i 2 (concatD [doc (showString "Int")])
    Tbool -> prPrec i 2 (concatD [doc (showString "Bool")])
    Tstring -> prPrec i 2 (concatD [doc (showString "String")])
    Tfun type_1 type_2 -> prPrec i 0 (concatD [doc (showString "("), prt 0 type_1, doc (showString "->"), prt 0 type_2, doc (showString ")")])
    Tfunarg type_1 type_2 -> prPrec i 2 (concatD [prt 0 type_1, doc (showString "->"), prt 0 type_2])

instance Print Decl_stmt where
  prt i e = case e of
    DeclVar dec -> prPrec i 0 (concatD [prt 0 dec, doc (showString ";")])
    DeclFn id ids stmt -> prPrec i 0 (concatD [doc (showString "def"), prt 0 id, doc (showString "("), prt 0 ids, doc (showString ")"), doc (showString ":"), prt 0 stmt])

instance Print [Ident] where
  prt = prtList

instance Print Compound_stmt where
  prt i e = case e of
    Scomp stmts -> prPrec i 0 (concatD [doc (showString "{"), prt 0 stmts, doc (showString "}")])

instance Print Iter_stmt where
  prt i e = case e of
    SiterOne exp stmt -> prPrec i 0 (concatD [doc (showString "while"), prt 0 exp, doc (showString ":"), prt 0 stmt])
    SiterTwo expressionstmt1 expressionstmt2 stmt -> prPrec i 0 (concatD [doc (showString "for"), prt 0 expressionstmt1, prt 0 expressionstmt2, doc (showString ":"), prt 0 stmt])
    SiterThree expressionstmt1 expressionstmt2 exp stmt -> prPrec i 0 (concatD [doc (showString "for"), prt 0 expressionstmt1, prt 0 expressionstmt2, prt 0 exp, doc (showString ":"), prt 0 stmt])

instance Print Expression_stmt where
  prt i e = case e of
    SexprEmpty -> prPrec i 0 (concatD [doc (showString ";")])
    Sexpr exp -> prPrec i 0 (concatD [prt 0 exp, doc (showString ";")])

instance Print Selection_stmt where
  prt i e = case e of
    Sif exp stmt -> prPrec i 0 (concatD [doc (showString "if"), prt 0 exp, doc (showString ":"), prt 0 stmt])
    SifElse exp stmt1 stmt2 -> prPrec i 0 (concatD [doc (showString "if"), prt 0 exp, doc (showString ":"), prt 0 stmt1, doc (showString "else"), doc (showString ":"), prt 0 stmt2])

instance Print Flow_stmt where
  prt i e = case e of
    Scontinue -> prPrec i 0 (concatD [doc (showString "continue"), doc (showString ";")])
    Sbreak -> prPrec i 0 (concatD [doc (showString "break"), doc (showString ";")])
    Sreturn exp -> prPrec i 0 (concatD [doc (showString "return"), prt 0 exp, doc (showString ";")])

instance Print Print_stmt where
  prt i e = case e of
    Sprint exp -> prPrec i 0 (concatD [doc (showString "print"), prt 0 exp, doc (showString ";")])

instance Print Constant where
  prt i e = case e of
    Einteger n -> prPrec i 0 (concatD [prt 0 n])
    Estring str -> prPrec i 0 (concatD [prt 0 str])
    Etrue -> prPrec i 0 (concatD [doc (showString "True")])
    Efalse -> prPrec i 0 (concatD [doc (showString "False")])

instance Print [Exp] where
  prt = prtList

instance Print Exp where
  prt i e = case e of
    Elambda decs exp -> prPrec i 1 (concatD [doc (showString "lambda"), prt 0 decs, doc (showString ":"), prt 0 exp])
    Eassign exp1 assignmentop exp2 -> prPrec i 2 (concatD [prt 14 exp1, prt 0 assignmentop, prt 0 exp2])
    Econdition exp1 exp2 exp3 -> prPrec i 3 (concatD [prt 4 exp1, doc (showString "?"), prt 0 exp2, doc (showString ":"), prt 3 exp3])
    Elor exp1 exp2 -> prPrec i 4 (concatD [prt 4 exp1, doc (showString "or"), prt 5 exp2])
    Eland exp1 exp2 -> prPrec i 5 (concatD [prt 5 exp1, doc (showString "and"), prt 6 exp2])
    Epreoplog unarylogoperator exp -> prPrec i 6 (concatD [prt 0 unarylogoperator, prt 5 exp])
    Eeq exp1 exp2 -> prPrec i 7 (concatD [prt 7 exp1, doc (showString "=="), prt 8 exp2])
    Eneq exp1 exp2 -> prPrec i 7 (concatD [prt 7 exp1, doc (showString "!="), prt 8 exp2])
    Elthen exp1 exp2 -> prPrec i 8 (concatD [prt 8 exp1, doc (showString "<"), prt 9 exp2])
    Egrthen exp1 exp2 -> prPrec i 8 (concatD [prt 8 exp1, doc (showString ">"), prt 9 exp2])
    Ele exp1 exp2 -> prPrec i 8 (concatD [prt 8 exp1, doc (showString "<="), prt 9 exp2])
    Ege exp1 exp2 -> prPrec i 8 (concatD [prt 8 exp1, doc (showString ">="), prt 9 exp2])
    Eplus exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString "+"), prt 10 exp2])
    Eminus exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString "-"), prt 10 exp2])
    Etimes exp1 exp2 -> prPrec i 10 (concatD [prt 10 exp1, doc (showString "*"), prt 11 exp2])
    Ediv exp1 exp2 -> prPrec i 10 (concatD [prt 10 exp1, doc (showString "/"), prt 11 exp2])
    Emod exp1 exp2 -> prPrec i 10 (concatD [prt 10 exp1, doc (showString "%"), prt 11 exp2])
    Earray exps -> prPrec i 10 (concatD [doc (showString "["), prt 0 exps, doc (showString "]")])
    Epreopexp unaryexpoperator exp -> prPrec i 11 (concatD [prt 0 unaryexpoperator, prt 10 exp])
    Epostinc exp -> prPrec i 12 (concatD [prt 12 exp, doc (showString "++")])
    Epostdec exp -> prPrec i 12 (concatD [prt 12 exp, doc (showString "--")])
    Efunkpar exp exps -> prPrec i 13 (concatD [prt 13 exp, doc (showString "("), prt 0 exps, doc (showString ")")])
    Earrayget exp1 exp2 -> prPrec i 14 (concatD [prt 14 exp1, doc (showString "["), prt 9 exp2, doc (showString "]")])
    Evar id -> prPrec i 15 (concatD [prt 0 id])
    Econst constant -> prPrec i 15 (concatD [prt 0 constant])
  prtList _ [] = concatD []
  prtList _ [x] = concatD [prt 0 x]
  prtList _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print Unary_exp_operator where
  prt i e = case e of
    Plus -> prPrec i 0 (concatD [doc (showString "+")])
    Negative -> prPrec i 0 (concatD [doc (showString "-")])

instance Print Unary_log_operator where
  prt i e = case e of
    Logicalneg -> prPrec i 0 (concatD [doc (showString "not")])

instance Print Assignment_op where
  prt i e = case e of
    Assign -> prPrec i 0 (concatD [doc (showString "=")])
    AssignMul -> prPrec i 0 (concatD [doc (showString "*=")])
    AssignDiv -> prPrec i 0 (concatD [doc (showString "/=")])
    AssignMod -> prPrec i 0 (concatD [doc (showString "%=")])
    AssignAdd -> prPrec i 0 (concatD [doc (showString "+=")])
    AssignSub -> prPrec i 0 (concatD [doc (showString "-=")])

