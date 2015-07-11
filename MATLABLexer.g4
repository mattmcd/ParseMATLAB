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

LBRACE : '{' ;

// RBRACE : '}' ;

LBRACK : '[' ;

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

TRANS : '.\'' ;

CTRANS : '\'' ;

// General rules
NL  : '\r'?'\n' ;

LINECONTINUE
    : '...' .*? NL -> skip ;

COMMENT
    : '%' .*? NL -> skip ;

fragment
LETTER  : [a-zA-Z] ; 
fragment
DIGIT   : [0-9] ; 
fragment
ESC : '\'\'' ;

NUMBER : DIGIT+ ;
ID  : LETTER (LETTER|DIGIT|'_')* ;
STRING : '\'' (ESC|.)*? '\'' ;

RBRACK : ']' ;
RBRACE : '}' ;

// HCAT : (COMMA); // | SPACE ) ;

// VCAT : (SEMI | NL ) ;

// ARRAYELSEP : (HCAT| VCAT ) ; // SPACE+ ;

COMMA : ',' ;

SEMI  : ';' ;

WS  : SPACE+ -> skip ;

fragment
SPACE : [ \t] ;

