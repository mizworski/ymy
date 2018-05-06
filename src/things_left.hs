

module PrettyMuchNothing where

-- Haskell module generated by the BNF converter




newtype Ident = Ident String deriving (Eq, Ord, Show, Read)
data Program = Progr [Stmt]
  deriving (Eq, Ord, Show, Read)

data Stmt
    = DeclS Decl_stmt
    | ExprS Expression_stmt
    | SelS Selection_stmt
    | IterS Iter_stmt
    | FlowS Flow_stmt
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

data Decl_stmt = DeclFn Ident [Ident] Stmt
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

data Exp
    = Elambda [Dec] Exp
    | Earray [Exp]
    | Efunkpar Exp [Exp]
    | Earrayget Exp Exp
  deriving (Eq, Ord, Show, Read)


