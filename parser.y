%{
#include<ctype.h>
#include<stdio.h>
#include"lex.yy.c"
%}
%token INTEGERNUM DOUBLENUM CHARVALUE
%token ID 
%token IF WHILE DO BREAK TRUE FALSE BASIC ELSE INDEX GE LE NE EQ AND OR READ WRITE
%%
program : stmts { printf("program-->success\n"); }
        ;
decls :
      | decls decl { printf("decls-->decls decl\n"); }
      ;
decl :
    BASIC IDs ';' { printf("decl-->type id\n"); }
    | BASIC IDs '=' bools ';' { printf("decl-->type id = values\n"); }
    |IDs '=' bools ';' { printf("decl--> id  = values\n"); }

    ;
IDs : ID'['value']' { printf("type-->type id[num]\n"); }
    |  ID { printf("type-->basic"); }
     |IDs','ID { printf("IDs-->ID");}
     ;
bools : bools','booL  { printf("bools-->bool,bools\n"); }
|booL { printf("bools-->bool\n"); }
;
stmts :
    | stmts stmt { printf("stmts-->stmts stmt\n"); }
    | stmts decls {printf("stmts--->stmts decls");}
      ;
stmt : matched_stmt { printf("stmt-->matched_stmt\n");}
     | open_stmt { printf("stmt-->open_stmt\n");}
     ;
open_stmt: IF '(' booL ')' stmt { printf("open_stmt-->if(bool)stmt\n");}
	 | IF '(' booL ')' matched_stmt ELSE open_stmt { printf("open_stmt-->if(bool) matched_stmt else open_stmt\n");}
         ;
matched_stmt: IF '(' booL ')' matched_stmt ELSE matched_stmt { printf("matched_stmt-->if(bool) matched_stmt else matched_stmt\n");}
	    | other { printf("matched_stmt-->other\n");}
            ;
other:
    loc '=' booL ';' { printf("stmt-->loc=bool;\n"); }
    | WHILE '(' booL ')' stmt { printf("stmt-->while(bool)stmt\n"); }
     | DO stmt WHILE '(' booL ')' ';' { printf("stmt-->do stmt while(bool);\n"); }
     | BREAK ';' { printf("stmt-->break;\n"); }
     | block { printf("stmt-->block\n"); }
     | WRITE '(' value ')'';' { printf("stmt-->write\n"); }
     | READ '(' value ')'';'{ printf("stmt-->read\n"); }
     ;
value : INTEGERNUM { printf("value-->integer\n"); }
     | DOUBLENUM { printf("value-->double\n"); }
     | CHARVALUE { printf("value-->char\n"); }
     | IDs { printf("value-->IDs\n"); }
     | expr { printf("vlaue--> expr"); }
block : '{' decls stmts '}' { printf("block-->{decls stmts}\n"); }
;
loc : loc '[' booL ']' { printf("loc-->loc[bool]\n"); }
|IDs { printf("loc-->IDs\n"); }
;
booL : booL OR join { printf("bool-->bool||join\n"); }
     | join { printf("bool-->join\n"); }
     ;
join : join AND equality { printf("join-->join&&equality\n"); }
     | equality { printf("join-->equality\n"); }
     ;
equality : equality EQ rel { printf("equality-->equality==rel\n"); }
         | equality NE rel { printf("equality-->equality!=rel\n"); }
 	 | rel { printf("equality-->rel\n"); }
	 ;
rel : expr '<' expr { printf("rel-->expr<expr\n"); }
    | expr LE expr { printf("rel-->expr<=expr\n"); } 
    | expr GE expr { printf("rel-->expr>=expr\n"); }
    | expr '>' expr { printf("rel-->expr>expr\n"); }
    | expr { printf("rel-->expr\n"); }
    ;
expr : expr '+' term { printf("expr-->expr+term\n"); }
     | expr '-' term { printf("expr-->expr-term\n"); }  
     | term { printf("expr-->term\n"); }
     ;
term : term '*' unary { printf("term-->term*unary\n"); }
     | term '/' unary { printf("term-->term/unary\n"); }
    | term '%' unary { printf("term-->term/unary\n"); }
     | unary { printf("term-->unary\n"); }
     ;
unary : '!' unary { printf("unary-->!unary\n"); }
      | '-' unary { printf("unary-->-unary\n"); }
      | factor { printf("unary-->factor\n"); }
      ;
factor : '(' booL ')' { printf("factor-->(bool)\n"); }
    | loc { printf("factor-->loc\n"); }
       | INTEGERNUM { printf("factor-->num\n"); }
       | DOUBLENUM {printf("factor-->num\n");}
       | TRUE { printf("factor-->true\n"); }
       | CHARVALUE { printf("factor-->char\n"); }
       | FALSE { printf("factor-->false\n"); }
   ;
%%

main(int argc, char** argv)
{
    if(argc > 1)
        yyin = fopen(argv[1], "r");
    else
        yyin = stdin;
//    printf("oh");
    yyparse();
//    return 0;
}
yyerror (char *s){

    fprintf(stderr,"error:%s\n",s);

}

