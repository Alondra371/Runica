# Runica — Context-Free Grammar (near-EBNF)

Program    ::= Header* Decl* Ritual+
Header     ::= "author" String ";" | "version" String ";"

Decl       ::= "var" Ident ":" Type ("=" Expr)? ";"
             | "item" Ident ("=" Int)? ";"
             | "sigil" Ident ";"

Type       ::= "Int" | "Bool" | "Text"

Ritual     ::= "ritual" Ident "{" Req* Stmt* "}"
Req        ::= "require" ReqAtom ("," ReqAtom)* ";"
ReqAtom    ::= "sigil(" Ident ")" 
             | "herb(" Ident ")"
             | "item(" Ident "," Int ")"

Stmt       ::= "if" Expr "then" Block ("else" Block)?
             | "invoke(" String ")" ";"
             | "fail(" String ")" ";"
             | "bind(" Ident "," Expr ")" ";"
             | "equate(" Expr "," Expr ")" ";"
             | "say" String ";"
             | "gain" Ident Int ";"
             | "consume" Ident Int ";"
             | "set" Ident ":=" Expr ";"

Block      ::= "{" Stmt* "}"

Expr       ::= OrExpr
OrExpr     ::= AndExpr ("or" AndExpr)*
AndExpr    ::= RelExpr ("and" RelExpr)*
RelExpr    ::= AddExpr (( "==" | "!=" | "<" | "<=" | ">" | ">=" ) AddExpr)*
AddExpr    ::= MulExpr (( "+" | "-" ) MulExpr)*
MulExpr    ::= Unary  (( "*" | "/" ) Unary)*
Unary      ::= ("not" | "-" )? Primary
Primary    ::= Int | String | "true" | "false" | Ident
             | "hasSigil(" Ident ")"
             | "hasHerb(" Ident ")"
             | "has(" Ident "," Int ")"
             | "(" Expr ")"

Tokens
- Ident  : [A-Za-z][A-Za-z0-9_]*
- Int    : [0-9]+
- String : " ... " (with escapes)
- Keywords: author, version, var, item, sigil, ritual, require, if, then, else,
  invoke, fail, bind, equate, say, gain, consume, set, true, false, and, or, not
