%option noyywrap
%{
    #include<ctype.h>
    #include<string.h>
    #include<stdio.h>
    #include<stdlib.h>
%}
INTEGER ([-+]?[1-9][0-9]*)|[0-9]
DOUBLE [-+]?[0-9]+\.[0-9]*
ID [a-zA-Z][a-zA-Z_0-9]*
SPACE [ \n\t]
COMMENT "/*"[^(*/)|\n]*"*/"|[/][/].*?$
CHAR [\"]([^\"]*)[\"]
%%
{SPACE}      { }
[/][/].*?$ {printf("COMMENT");}
"/*"([^("*/")]|\n)*"*/" {printf("COMMENTS");}
"if"      {printf("IF  ");return(IF);}
"else"    {printf("ELSE  ");return(ELSE);}
"read"    {printf("READ  ");return(READ);}
"write"   {printf("WRITE  ");return(WRITE);}
"int"     {printf("INT  "); return(BASIC);}
"float"   {printf("FLOAT  "); return(BASIC);}
"break"   {printf("BREAK  ");return(BREAK);}
"do"      {printf("DO  ");return(DO);}
"while"   {printf("WHILE  ");return(WHILE);}
"True"    {printf("TRUE  ");return(TRUE);}
"index"   {printf("INDEX  "); return(INDEX);}
"bool"    {printf("BOOL  "); return(BASIC);}
"char"    {printf("CHAR  "); return(BASIC);}
"real"    {printf("real(double)  ");return(BASIC);}
"False"   {printf("FLASE  "); return(FALSE);}
{ID} {printf("ID ");return(ID);}
{DOUBLE} {printf("DoubleNUM   "); return(DOUBLENUM);}
{INTEGER} { printf("IntegerNUM   ");return(INTEGERNUM); }
{CHAR}   { printf("Char Value  ");return(CHARVALUE);}
"<"       {printf("LT  ");return('<');}
"<="      {printf("LE  ");return(LE);}
"="       {printf("=  ");return('=');}
"=="      {printf("==  ");return(EQ);}
"!="      {printf("!=  ");return(NE);}
"<>"      {printf("!=  ");return(NE);}
">"       {printf(">  ");return('>');}
">="      {printf(">=  ");return(GE);}
"&&"      {printf("and  ");return(AND);}
"||"      {printf("or  ");return(OR);}
"+"       {printf("+  ");return('+');}
"-"       {printf("-  ");return('-');}
"*"       {printf("*  ");return('*');}
"/"       {printf("/  ");return('/');}
"%"       {printf("%  ");return('%');}
"["       {printf("[  ");return('[');}
"]"       {printf("]  ");return(']');}
"{"       {printf("{  ");return('{');}
"}"       {printf("}  ");return('}');}
"("       {printf("(  ");return('(');}
")"       {printf(")  ");return(')');}
";"       {printf(";  ");return(';');}
","       {printf(",  ");return(',');}
[\r][\n] {}
.       {
    //printf(" illegal character %s\n",  yytext);
    //yyterminate();
}
%%