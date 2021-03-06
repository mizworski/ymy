

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
    | Tfun Type Type
    | Tarray Type
    | Tint
    | Tbool
    | Tstring
    | Tany
    | Tinvalid
    | Tfunarg Type Type
  deriving (Ord, Show, Read)

data Decl_stmt = DeclVar Dec | DeclFn Dec [Dec] Stmt
  deriving (Eq, Ord, Show, Read)

data Compound_stmt = Scomp [Stmt]
  deriving (Eq, Ord, Show, Read)

data Iter_stmt
    = Swhile Exp Stmt
    | Sfor Expression_stmt Expression_stmt Exp Stmt
    | Sfornoinc Expression_stmt Expression_stmt Stmt
  deriving (Eq, Ord, Show, Read)

data Expression_stmt = SexprEmpty | Sexpr Exp
  deriving (Eq, Ord, Show, Read)

data Selection_stmt = Sif Exp Stmt | SifElse Exp Stmt Stmt
  deriving (Eq, Ord, Show, Read)

data Flow_stmt = Scontinue | Sbreak | Sreturn Exp | SreturnVoid
  deriving (Eq, Ord, Show, Read)

data Print_stmt = Sprint Exp
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
    | Elength Exp
    | Epostinc Exp
    | Epostdec Exp
    | Efunkpar Exp [Exp]
    | Earrayget Exp Exp
    | Earrgetcom Exp [Exp]
    | Evar Ident
    | Econst Constant
  deriving (Eq, Ord, Show, Read)

data Constant = Einteger Integer | Estring String | Etrue | Efalse
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

instance Eq Type where
  Tany == _ = True
  _ == Tany = True
  Tunit == Tunit = True
  Tint == Tint = True
  Tbool == Tbool = True
  Tstring == Tstring = True
  Tinvalid == Tinvalid = True
  (Tarray t1) == (Tarray t2) = t1 == t2
  (Tfun f1 f2) == (Tfun g1 g2) = (f1 == g1) && (f2 == g2)
  (Tfunarg f1 f2) == (Tfunarg g1 g2) = (f1 == g1) && (f2 == g2)
  (Tfun f1 f2) == (Tfunarg g1 g2) = (f1 == g1) && (f2 == g2)
  (Tfunarg f1 f2) == (Tfun g1 g2) = (f1 == g1) && (f2 == g2)
  _ == _ = False
