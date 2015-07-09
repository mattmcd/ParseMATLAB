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
    : 'function' outArgs? ID inArgs? endStat statBlock 
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
    : 'classdef' ID endStat 
      (propBlockDecl|methodBlockDecl)* 
      'end' (EOF|endStat) NL*
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

statBlock
    : (stat endStat)*
    ;

ifStat
    : 'if' expr endStat statBlock 
      ('elseif' expr endStat statBlock)* 
      ('else' endStat? statBlock)?
      'end'
    ;

whileStat
    : 'while' expr endStat statBlock 'end'
    ;

caseStat
    : 'switch' expr endStat 
      ('case' expr endStat statBlock)*
      ('otherwise' endStat statBlock)?
      'end'
    ;

stat
    : dotRef '=' expr
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
    : '[' expr (arraySep expr)* ']'
    | '[' ']'
    ;

cellExpr
    : '{' expr (arraySep expr)* '}'
    | '{' '}'
    ;

expr
    : expr '(' exprList ')'
    | expr ('\''|'.\''|'.^'|'^') expr
    | ('+'|'-'|'~') expr
    | expr ('*'|'.*'|'/'|'./'|'\\'|'.\\') expr
    | expr ('+'|'-') expr
    | expr ':' expr
    | expr ('~'|'=='|'>'|'<'|'>='|'<=') expr
    | expr '&' expr
    | expr '|' expr
    | expr '&&' expr
    | expr '||' expr
    | dotRef
    | NUMBER
    | STRING
    | arrayExpr
    | cellExpr
    | '(' expr ')'
    ;

exprList
    : expr (',' expr)*
    ;

fragment
DIGIT   
    : [0-9] ;

NL  : '\r'?'\n' ;

WS  : [ \t]+ -> skip ;

LINECONTINUE
    : '...' .*? NL -> skip ;

COMMENT
    : '%' .*? NL -> skip ;

COMMA : ',' ;

SEMI  : ';' ;

fragment
LETTER  
    : [a-zA-Z] ;

ID  : LETTER (LETTER|DIGIT|'_')* ;

NUMBER : DIGIT+ ;

STRING
    : '\'' (ESC|.)*? '\'' 
    ;

fragment
ESC : '\'\'' ;

