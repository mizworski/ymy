module SkelYmyLang where

-- Haskell module generated by the BNF converter

import AbsYmyLang
import ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transIdent :: Ident -> Result
transIdent x = case x of
  Ident string -> failure x
transProgram :: Program -> Result
transProgram x = case x of
  Progr stmts -> failure x
transStmt :: Stmt -> Result
transStmt x = case x of
  DeclS declstmt -> failure x
  CompS compoundstmt -> failure x
  ExprS expressionstmt -> failure x
  SelS selectionstmt -> failure x
  IterS iterstmt -> failure x
  FlowS flowstmt -> failure x
  PrintS printstmt -> failure x
transDec :: Dec -> Result
transDec x = case x of
  Declarator ident type_ -> failure x
transType :: Type -> Result
transType x = case x of
  Tunit -> failure x
  Tfun type_1 type_2 -> failure x
  Tarray type_ -> failure x
  Tint -> failure x
  Tbool -> failure x
  Tstring -> failure x
  Tany -> failure x
  Tinvalid -> failure x
  Tfunarg type_1 type_2 -> failure x
transDecl_stmt :: Decl_stmt -> Result
transDecl_stmt x = case x of
  DeclVar dec -> failure x
  DeclFn dec decs stmt -> failure x
transCompound_stmt :: Compound_stmt -> Result
transCompound_stmt x = case x of
  Scomp stmts -> failure x
transIter_stmt :: Iter_stmt -> Result
transIter_stmt x = case x of
  Swhile exp stmt -> failure x
  Sfor expressionstmt1 expressionstmt2 exp stmt -> failure x
  Sfornoinc expressionstmt1 expressionstmt2 stmt -> failure x
transExpression_stmt :: Expression_stmt -> Result
transExpression_stmt x = case x of
  SexprEmpty -> failure x
  Sexpr exp -> failure x
transSelection_stmt :: Selection_stmt -> Result
transSelection_stmt x = case x of
  Sif exp stmt -> failure x
  SifElse exp stmt1 stmt2 -> failure x
transFlow_stmt :: Flow_stmt -> Result
transFlow_stmt x = case x of
  Scontinue -> failure x
  Sbreak -> failure x
  Sreturn exp -> failure x
  SreturnVoid -> failure x
transPrint_stmt :: Print_stmt -> Result
transPrint_stmt x = case x of
  Sprint exp -> failure x
transExp :: Exp -> Result
transExp x = case x of
  Elambda decs exp -> failure x
  Eassign exp1 assignmentop exp2 -> failure x
  Econdition exp1 exp2 exp3 -> failure x
  Elor exp1 exp2 -> failure x
  Eland exp1 exp2 -> failure x
  Epreoplog unarylogoperator exp -> failure x
  Eeq exp1 exp2 -> failure x
  Eneq exp1 exp2 -> failure x
  Elthen exp1 exp2 -> failure x
  Egrthen exp1 exp2 -> failure x
  Ele exp1 exp2 -> failure x
  Ege exp1 exp2 -> failure x
  Eplus exp1 exp2 -> failure x
  Eminus exp1 exp2 -> failure x
  Etimes exp1 exp2 -> failure x
  Ediv exp1 exp2 -> failure x
  Emod exp1 exp2 -> failure x
  Earray exps -> failure x
  Epreopexp unaryexpoperator exp -> failure x
  Epostinc exp -> failure x
  Epostdec exp -> failure x
  Efunkpar exp exps -> failure x
  Earrayget exp1 exp2 -> failure x
  Earrgetcom exp exps -> failure x
  Evar ident -> failure x
  Econst constant -> failure x
transConstant :: Constant -> Result
transConstant x = case x of
  Einteger integer -> failure x
  Estring string -> failure x
  Etrue -> failure x
  Efalse -> failure x
transUnary_exp_operator :: Unary_exp_operator -> Result
transUnary_exp_operator x = case x of
  Plus -> failure x
  Negative -> failure x
transUnary_log_operator :: Unary_log_operator -> Result
transUnary_log_operator x = case x of
  Logicalneg -> failure x
transAssignment_op :: Assignment_op -> Result
transAssignment_op x = case x of
  Assign -> failure x
  AssignMul -> failure x
  AssignDiv -> failure x
  AssignMod -> failure x
  AssignAdd -> failure x
  AssignSub -> failure x

