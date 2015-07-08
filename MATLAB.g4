grammar MATLAB;

fileDecl  
    : (functionDecl | classDecl)? (functionDecl* | partialFunctionDecl*)
    | partialFunctionDecl*
    | stat* // Script
    ;

// Function declaration without the closing end
partialFunctionDecl
    : 'function' outArgs? ID inArgs? NL stat* 
    ; 

// Normal function declaration including closing end
functionDecl
    : partialFunctionDecl 'end' NL+
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
