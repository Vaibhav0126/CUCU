%{
#include<stdio.h>
#include<stdlib.h>
#include "cucu.tab.h"
extern FILE *yyout,*yyin;
void yyerror(char *s);

%}
   
%%    
[,]             {fprintf(yyout,"COMMA: %s\n",yytext);yylval.st=strdup(yytext);}
"return"        {fprintf(yyout,"RETURN: %s\n",yytext);yylval.st=strdup(yytext);return RET;}   
[&]             {fprintf(yyout,"AND: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[|]             {fprintf(yyout,"OR: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[-]             {fprintf(yyout,"MINUS: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[+]             {fprintf(yyout,"PLUS: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[=]            {fprintf(yyout,"ASSIGN: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[(]             {fprintf(yyout,"LEFT_PAREN: %s\n",yytext);yylval.st=strdup(yytext);}
[)]             {fprintf(yyout,"RIGHT_PAREN: %s\n",yytext);yylval.st=strdup(yytext);}
[<]             {fprintf(yyout,"LESS_THAN: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[>]             {fprintf(yyout,"GREATER_THAN: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[\d*\d]             {fprintf(yyout,"MULT: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[*]{2}            {fprintf(yyout,"ASTS: %s\n",yytext);yylval.st=strdup(yytext);return DAST;}
[/]             {fprintf(yyout,"DIVIDE: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[%]             {fprintf(yyout,"MOD: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[;]           {fprintf(yyout,"SEMICOL: %s\n",yytext);yylval.st=strdup(yytext);}
[{]             {fprintf(yyout,"LEFT_BRACE: %s\n",yytext);yylval.st=strdup(yytext);}
[}]             {fprintf(yyout,"RIGHT_BRACE: %s\n",yytext);yylval.st=strdup(yytext);}
[\[]            {fprintf(yyout,"LEFT_SQ: %s\n",yytext);yylval.st=strdup(yytext);}
[\]]             {fprintf(yyout,"RIGHT_SQ: %s\n",yytext);yylval.st=strdup(yytext);}
[>][=]            {fprintf(yyout,"GT_EQUAL: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[<][=]            {fprintf(yyout,"LT_EQUAL: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[=]{2}            {fprintf(yyout,"EQUALS: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
[!][=]            {fprintf(yyout,"NOT_EQUAL: %s\n",yytext);yylval.st=strdup(yytext);return OP;}
["]               {fprintf(yyout,"D_QUOTES: %s\n",yytext);yylval.st=strdup(yytext);return DQ;}
["].*["]          { return STR; }
main         {fprintf(yyout,"MAIN: %s\n",yytext);yylval.st=strdup(yytext);return IDS;}
while        {fprintf(yyout,"WHILE: %s\n",yytext);yylval.st=strdup(yytext);return WHILE;}
if           {fprintf(yyout,"IF: %s\n",yytext);yylval.st=strdup(yytext);return IF;}
else          {fprintf(yyout,"ELSE: %s\n",yytext);yylval.st=strdup(yytext);return ELSE;}
int           {fprintf(yyout,"TYPE: %s\n",yytext);yylval.st=strdup(yytext);return DATA;}
char          {fprintf(yyout,"TYPE: %s\n",yytext);yylval.st=strdup(yytext);return DATA;}
"char**"          {fprintf(yyout,"TYPE: %s\n",yytext);yylval.st=strdup(yytext);return DATA;}
"char*"          {fprintf(yyout,"TYPE: %s\n",yytext);yylval.st=strdup(yytext);return DATA;}
\/\/.*               ;
\/\*(.*\n)*.*\*\/    ;
[a-zA-A_][a-zA-Z0-9_]*   { 
        yylval.st=strdup(yytext);
              fprintf(yyout,"ID : %s\n",yytext);
               return IDS;};
[0-9][0-9]* {
        yylval.nums=atoi(yytext);
 fprintf(yyout,"NUM : %d\n",atoi(yytext));
 return NMS;
 };          

[ \t\n]+       ; 
.            {yyerror("");};
%%











