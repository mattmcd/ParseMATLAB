parser grammar MATLABParser;

options { tokenVocab=MATLABLexer;}

fileDecl  
    : (functionDecl | classDecl)? (functionDecl* | partialFunctionDecl*)
    | partialFunctionDecl*
    | stat* // Script
    ;

endStat
    : (NL|COMMA|SEMI) NL*
    ;

endStatNL 
    : NL+
    ;

// Function declaration without the closing end
partialFunctionDecl
    : FUNCTION outArgs? ID inArgs? endStat statBlock 
    ; 

// Normal function declaration including closing end
functionDecl
    : partialFunctionDecl END endStatNL NL*
    ;

// Functions inside method blocks can be comma or semi separated 
methodDecl
    : partialFunctionDecl END endStat
    ;

classDecl
    : CLASSDEF ID endStat 
      (propBlockDecl|methodBlockDecl)* 
      END (EOF|endStat) NL*
    ;

propBlockDecl
    : PROPERTIES endStat prop* END endStat
    ;

methodBlockDecl
    : METHODS endStat methodDecl* END endStat
    ;

outArgs
    : ID EQUALS
    | LBRACK ID (',' ID)* RBRACK EQUALS
    ;

inArgs
    : LPAREN ID (',' ID)* RPAREN
    | LPAREN RPAREN
    ;

prop
    : ID (EQUALS expr)? endStat
    ;

dotRef
    : ID (DOT ID)*
    ;

statBlock
    : (stat endStat)*
    ;

ifStat
    : IF expr endStat statBlock 
      (ELSEIF expr endStat statBlock)* 
      (ELSE endStat? statBlock)?
      END
    ;

whileStat
    : WHILE expr endStat statBlock END
    ;

caseStat
    : SWITCH expr endStat 
      (CASE expr endStat statBlock)*
      (OTHERWISE endStat statBlock)?
      END
    ;

stat
    : dotRef EQUALS expr
    | ifStat
    | whileStat
    | caseStat
    | expr 
    | NL
    ;

arraySep
    : (COMMA | SEMI)
    ;

arrayExpr
    : LBRACK expr (arraySep expr)* RBRACK
    | LBRACK RBRACK
    ;

cellExpr
    : LBRACE expr (arraySep expr)* RBRACE
    | LBRACE RBRACE
    ;

expr
    : expr LPAREN exprList RPAREN
    | expr (LDIVIDE|MLDIVIDE|MPOW|POW) expr
    | (PLUS|MINUS|NOT) expr
    | expr (MTIMES|TIMES|MLDIVIDE|LDIVIDE|MRDIVIDE|RDIVIDE) expr
    | expr (PLUS|MINUS) expr
    | expr COLON expr
    | expr (NOT|EQUALTO|GT|LT|GE|LE) expr
    | expr VECAND expr
    | expr VECOR expr
    | expr SCALAND expr
    | expr SCALOR expr
    | dotRef
    | NUMBER
    | STRING
    | arrayExpr
    | cellExpr
    | LPAREN expr RPAREN
    ;

exprList
    : expr (',' expr)*
    ;
