grammar MATLAB;

fileDecl  
    : (functionDecl | classDecl)? functionDecl*
    | stat* // Script
    ;

functionDecl
    : 'function' outArgs? ID inArgs? NL stat* 'end' NL+
    ;

classDecl
    : 'classdef' ID NL (propDecl|methodDecl)* 'end' NL+
    ;

propDecl
    : 'properties' NL prop* 'end' NL+
    ;

methodDecl
    : 'methods' NL functionDecl* 'end' NL+
    ;

outArgs
    : ID '='
    | '[' ID (',' ID)* ']' '='
    ;

inArgs
    : '(' ID (',' ID)* ')'
    | '(' ')'
    ;

prop
    : ID ('=' expr)? NL
    ;

stat
    : ID
    | NL
    ;

expr
    : ID
    ;

fragment
DIGIT   
    : [0-9] ;

NL  : '\r'?'\n' ;

WS  : [ \t]+ -> skip ;

fragment
LETTER  
    : [a-zA-Z] ;

ID  : LETTER (LETTER|DIGIT|'_')* ;
