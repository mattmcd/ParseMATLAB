lexer grammar MATLABLexer;

// Keywords
FUNCTION : 'function' ;

CLASSDEF : 'classdef' ;

PROPERTIES : 'properties' ;

METHODS : 'methods' ; 

END : 'end' ;

IF  : 'if' ;

ELSEIF : 'elseif' ;

ELSE : 'else' ;

WHILE : 'while' ;

SWITCH : 'switch' ;

CASE : 'case' ; 

OTHERWISE : 'otherwise' ;

// Symbols
EQUALS : '=' ;

EQUALTO : '==' ;

GT : '>' ;

LT : '<' ;

GE : '>=' ;

LE : '<=' ;

PLUS : '+' ;

MINUS : '-' ;

DOT : '.' ;

VECAND : '&' ;

VECOR : '|' ;

SCALAND : '&&' ;

SCALOR : '||' ;

LPAREN : '(' ;

RPAREN : ')' ;

LBRACE : '{' WS* -> pushMode(CELLDEF) ;

// RBRACE : '}' ;

LBRACK : '[' WS* -> pushMode(ARRAYDEF) ;

// RBRACK : ']' ;

MTIMES : '*' ;

TIMES : '.*' ;

RDIVIDE : '/' ;

LDIVIDE : '\\' ;

MRDIVIDE : './' ;

MLDIVIDE : '.\\' ;

POW : '.^' ;

MPOW : '^' ;

NOT : '~' ;

COLON : ':' ;

// General rules
NL  : '\r'?'\n' ;

WS  : [ \t]+ -> skip ;

LINECONTINUE
    : '...' .*? NL -> skip ;

COMMENT
    : '%' .*? NL -> skip ;

COMMA : ',' ;

SEMI  : ';' ;

fragment
LETTER  : [a-zA-Z] ; 
fragment
DIGIT   : [0-9] ; 
fragment
ESC : '\'\'' ;

NUMBER : DIGIT+ ;
ID  : LETTER (LETTER|DIGIT|'_')* ;
STRING : '\'' (ESC|.)*? '\'' ;

mode ARRAYDEF;
RBRACK : ']' -> popMode;

ARRAYCOMMENT 
    : ('%'|'...') [^\r\n]* -> skip;

ARRAYELSEP : ([,; ]|NL) ARRAYWS* ;

ARRAYWS : [ \t\r\n]+ ;

ARRAYEL : [^\]]+ ;

mode CELLDEF;
RBRACE : '}' -> popMode;

CELLCOMMENT 
    : ('%'|'...') [^\r\n]* -> skip;

CELLELSEP : ([,; ]|NL) CELLWS* ;

CELLWS : [ \t\r\n]+ ;

CELLEL : [^}]+ ;
