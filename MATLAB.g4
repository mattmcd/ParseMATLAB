grammar MATLAB;

fileDecl  
    : (functionDecl | classDecl)? (functionDecl* | partialFunctionDecl*)
    | partialFunctionDecl*
    | stat* // Script
    ;

endStat
    : (NL|COMMA|SEMI)
    ;

endStatNL 
    : NL
    ;

// Function declaration without the closing end
partialFunctionDecl
    : 'function' outArgs? ID inArgs? endStat (stat endStat NL*)* 
    ; 

// Normal function declaration including closing end
functionDecl
    : partialFunctionDecl 'end' endStatNL NL*
    ;

// Functions inside method blocks can be comma or semi separated 
methodDecl
    : partialFunctionDecl 'end' endStat NL*
    ;

classDecl
    : 'classdef' ID endStat NL* (propBlockDecl|methodBlockDecl)* 'end' (EOF|endStat) NL*
    ;

propBlockDecl
    : 'properties' endStat NL* prop* 'end' endStat NL*
    ;

methodBlockDecl
    : 'methods' endStat NL* methodDecl* 'end' endStat NL*
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
    | 'if' expr endStat (stat endStat NL*)* 
      ('elseif' expr endStat (stat endStat NL*)*)* 
      ('else' endStat (stat endStat NL*)*)* 
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
