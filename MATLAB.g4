grammar MATLAB;

fileDecl  : functionDecl // (functionDecl | classDecl)? functionDecl*
    // | stat* // Script
    ;

functionDecl
    : 'function' outArgs? ID inArgs? NL
    ;

outArgs
    : ID '='
    | '[' ID (',' ID)* ']' '='
    ;

inArgs
    : '(' ID (',' ID)* ')'
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
