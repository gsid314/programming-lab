

%{


#include "parser.tab.h"
%}

DIGIT [0-9]
ID [A-Za-z][A-Za-z0-9]*
WHITESPACE [ \n\t]+
%option noyywrap
%option yylineno
%%

{DIGIT}+ {
yylval.ival =atoi( yytext ) ;return NUM;
}
[0-9]+"."[0-9]+  yylval.dval = atof(yytext);return NUM_REAL;
FOR      return FOR;

BEGIN     return BGN;

END    return EN;

END\.   return END_DOT;

PROGRAM  return PROGRAM;
 
VAR   return VAR;

READ   return READ;

DO    return DO;

WRITE  return WRITE;

INTEGER  return INTEGER_TYPE;

TO   return TO;

DIV   return DIV;

REAL return REAL;

"+"  return ADD;
"-"  return MINUS;
"*" return MUL;
"," return COMMA;
";" return SEMICOLON;
":" return COLON;
":=" return ASSIGN;
"(" return OPEN_PAREN;
")" return CLOSE_PAREN;
{ID}  yylval.sval = (char *)malloc(yyleng + 1);strcpy(yylval.sval, yytext);return ID;
"{"[^}\n]*"}" 
[ \n\t]+ 
. printf("Unrecognized character %s\n",yytext);
%%


