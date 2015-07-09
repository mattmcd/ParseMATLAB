grammar MATLAB;

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
    : 'function' outArgs? ID inArgs? endStat (stat endStat)* 
    ; 

// Normal function declaration including closing end
functionDecl
    : partialFunctionDecl 'end' endStatNL NL*
    ;

// Functions inside method blocks can be comma or semi separated 
methodDecl
    : partialFunctionDecl 'end' endStat
    ;

classDecl
    : 'classdef' ID endStat (propBlockDecl|methodBlockDecl)* 'end' (EOF|endStat) NL*
    ;

propBlockDecl
    : 'properties' endStat prop* 'end' endStat
    ;

methodBlockDecl
    : 'methods' endStat methodDecl* 'end' endStat
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
    : ID ('=' expr)? endStat
    ;

dotRef
    : ID ('.' ID)*
    ;

stat
    : dotRef '=' expr
    | 'if' expr endStat (stat endStat)* 
      ('elseif' expr endStat (stat endStat)*)* 
      ('else' endStat (stat endStat)*)* 
      'end'
    | ID
    | NL
    ;

expr
    : expr '==' expr
    | expr ('>'|'<'|'>='|'<=') expr
    | dotRef
    | NUMBER
    ;

fragment
DIGIT   
    : [0-9] ;

NL  : '\r'?'\n' ;

WS  : [ \t]+ -> skip ;

COMMA : ',' ;

SEMI  : ';' ;

fragment
LETTER  
    : [a-zA-Z] ;

ID  : LETTER (LETTER|DIGIT|'_')* ;

NUMBER : DIGIT+ ;
