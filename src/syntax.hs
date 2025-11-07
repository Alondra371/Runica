module Syntax where

type Name = String

-- Program = headers + decls + rituals
data Program = Program { headers :: [Header], decls :: [Decl], rituals :: [Ritual] }
  deriving (Eq, Show)

data Header = HAuthor String | HVersion String
  deriving (Eq, Show)

data Decl
  = DVar Name Type (Maybe Expr)   -- var x : Int = 3
  | DItem Name (Maybe Int)        -- item sage = 2
  | DSigil Name                   -- sigil north
  deriving (Eq, Show)

data Type = TInt | TBool | TText
  deriving (Eq, Show)

data Ritual = Ritual Name [Req] [Stmt]
  deriving (Eq, Show)

data Req = RNeedSigil Name | RNeedHerb Name | RNeedItem Name Int
  deriving (Eq, Show)

data Stmt
  = SIf Expr [Stmt] (Maybe [Stmt])
  | SInvoke String
  | SFail String
  | SBind Name Expr
  | SEquate Expr Expr
  | SSay String
  | SGain Name Int
  | SConsume Name Int
  | SSet Name Expr
  deriving (Eq, Show)

data Expr
  = EInt Int | EText String | EBool Bool | EVar Name
  | EHasSigil Name | EHasHerb Name | EHas Name Int
  | EUnary UOp Expr
  | EBin BOp Expr Expr
  deriving (Eq, Show)

data UOp = UNeg | UNot deriving (Eq, Show)

data BOp
  = Add | Sub | Mul | Div
  | Eq | Ne | Lt | Le | Gt | Ge
  | And | Or
  deriving (Eq, Show)
-- === Examples in ABSTRACT SYNTAX (counts toward the requirement) ===

-- Example A: ProtectionCircle
protectionProgram :: Program
protectionProgram =
  Program
    [HAuthor "Alondra", HVersion "0.2"]
    [ DVar "energy" TInt (Just (EInt 60))
    , DItem "sage" (Just 2)
    , DItem "salt" (Just 1)
    , DSigil "north"
    , DSigil "east"
    ]
    [ Ritual "ProtectionCircle"
        [ RNeedSigil "north", RNeedSigil "east", RNeedHerb "sage", RNeedItem "salt" 1 ]
        [ SIf (EBin And
                (EBin And (EHasSigil "north") (EHasSigil "east"))
                (EBin And (EHas "salt" 1) (EBin Gt (EVar "energy") (EInt 50))))
              [ SConsume "salt" 1
              , SSay "The circle tightens."
              , SInvoke "shield-on"
              ]
              (Just [ SFail "Circle incomplete or energy low." ])
        ]
    ]

-- Example B: BindingRitual
bindingProgram :: Program
bindingProgram =
  Program
    [HAuthor "Alondra", HVersion "0.2"]
    [ DVar "force"  TInt (Just (EInt 0))
    , DVar "anchor" TInt (Just (EInt 0))
    , DItem "obsidian" (Just 1)
    , DSigil "south"
    ]
    [ Ritual "BindingRitual"
        [ RNeedSigil "south", RNeedHerb "sage", RNeedItem "obsidian" 1 ]
        [ SBind "force" (EBin Add (EBin Mul (EInt 3) (EVar "anchor")) (EInt 2))
        , SSet "anchor" (EInt 4)
        , SEquate (EVar "force") (EBin Add (EBin Mul (EInt 3) (EVar "anchor")) (EInt 2))
        , SIf (EBin And
                (EBin And (EHasSigil "south") (EHas "obsidian" 1))
                (EBin Eq (EVar "force") (EInt 14)))
              [ SSay "The entity falters."
              , SInvoke "bind-entity"
              ]
              (Just [ SFail "Binding unstable; recompute." ])
        ]
    ]