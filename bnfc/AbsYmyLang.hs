

module AbsYmyLang where

-- Haskell module generated by the BNF converter




newtype Ident = Ident String deriving (Eq, Ord, Show, Read)
data Program = Progr [Stmt]
  deriving (Eq, Ord, Show, Read)

data Stmt
    = DeclS Decl_stmt
    | CompS Compound_stmt
    | ExprS Expression_stmt
    | SelS Selection_stmt
    | IterS Iter_stmt
    | FlowS Flow_stmt
    | PrintS Print_stmt
  deriving (Eq, Ord, Show, Read)

data Dec = Declarator Ident Type
  deriving (Eq, Ord, Show, Read)

data Type
    = Tunit
    | Tarray Type
    | Tint
    | Tbool
    | Tstring
    | Tfun Type Type
    | Tfunarg Type Type
  deriving (Eq, Ord, Show, Read)

data Decl_stmt = DeclVar Dec | DeclFn Ident [Ident] Stmt
  deriving (Eq, Ord, Show, Read)

data Compound_stmt = Scomp [Stmt]
  deriving (Eq, Ord, Show, Read)

data Iter_stmt
    = SiterOne Exp Stmt
    | SiterTwo Expression_stmt Expression_stmt Stmt
    | SiterThree Expression_stmt Expression_stmt Exp Stmt
  deriving (Eq, Ord, Show, Read)

data Expression_stmt = SexprEmpty | Sexpr Exp
  deriving (Eq, Ord, Show, Read)

data Selection_stmt = Sif Exp Stmt | SifElse Exp Stmt Stmt
  deriving (Eq, Ord, Show, Read)

data Flow_stmt = Scontinue | Sbreak | Sreturn Exp
  deriving (Eq, Ord, Show, Read)

data Print_stmt = Sprint Exp
  deriving (Eq, Ord, Show, Read)

data Constant = Einteger Integer | Estring String | Etrue | Efalse
  deriving (Eq, Ord, Show, Read)

data Exp
    = Elambda [Dec] Exp
    | Eassign Exp Assignment_op Exp
    | Econdition Exp Exp Exp
    | Elor Exp Exp
    | Eland Exp Exp
    | Epreoplog Unary_log_operator Exp
    | Eeq Exp Exp
    | Eneq Exp Exp
    | Elthen Exp Exp
    | Egrthen Exp Exp
    | Ele Exp Exp
    | Ege Exp Exp
    | Eplus Exp Exp
    | Eminus Exp Exp
    | Etimes Exp Exp
    | Ediv Exp Exp
    | Emod Exp Exp
    | Earray [Exp]
    | Epreopexp Unary_exp_operator Exp
    | Epostinc Exp
    | Epostdec Exp
    | Efunkpar Exp [Exp]
    | Earrayget Exp Exp
    | Evar Ident
    | Econst Constant
  deriving (Eq, Ord, Show, Read)

data Unary_exp_operator = Plus | Negative
  deriving (Eq, Ord, Show, Read)

data Unary_log_operator = Logicalneg
  deriving (Eq, Ord, Show, Read)

data Assignment_op
    = Assign
    | AssignMul
    | AssignDiv
    | AssignMod
    | AssignAdd
    | AssignSub
  deriving (Eq, Ord, Show, Read)

