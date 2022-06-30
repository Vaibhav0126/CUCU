
%{
#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#define fp fprintf

extern FILE *yyin,*yyout;
extern char *yytext;
FILE *out;
void yyerror(char *s) {fp(out,"ERROR\n");}
int yylex();

%}

%union{
int nums;
char *st;
}

%token<st> IDS IF ELSE WHILE  ASSIGN  OP DAST LSQ RSQ  DATA RET MAIN DQ STR
%token<nums> NMS

%%

start : start begin
       | begin
       ;

begin :  vdc  
        | fdc 
        | fdf
        | fc
        | If
        | While
        | stmts
        ;

fdf :   DATA IDS "(" arguments ")" "{" bodies "}" {fp(out,"Ident-%s\n",$2);}
        | DATA IDS "("  ")" "{" bodies "}" {fp(out,"Ident-%s\n",$2);}
            ; 

fdc : DATA IDS "(" arguments ")" ";" {fp(out,"Variable- %s ",$1);
          fp(out,"Function Declaration: %s \n",$2);}
          ;
                           
stmts:     IDS ASSIGN expr ";"                      {fp(out,"Variable: %s  ",$1}    
          | IDS LSQ expr RSQ ASSIGN expr ";"         {fp(out,"Variable: %s  ",$1);}
           | IDS "++" ";"                      {fp(out,"Variable: %s  ",$1);}    
           | IDS "--" ";"                        {fp(out,"Variable: %s  ",$1);} 
           ;
           
fc :       IDS "(" calling ")" ";" {fp(out,"Var- %s ",$1);fp(out,"\nFUN ends\nFUN-CALL\n");}
           | IDS "("  ")" ";" {fp(out,"Var- %s ",$1);fp(out,"\nFUN ends\nFUN-CALL\n");}
           | RET  expr ";"               {fp(out," RET\n");}  
           | RET "(" expr ")" ";"  {fp(out," RET\n");}
          ;

calling :  expr {fp(out,"FUN-ARG\n");}
          | calling "," expr {fp(out,"FUN-ARG\n");}                 
          ;
                     
vdc :    DATA IDS  ";" {fp(out,"local variable %s\n",$2);}
        | DATA IDS ASSIGN expr ";" {fp(out,":= \nlocal variable: %s\n",$2);}
        | DATA IDS "["expr "]" ";" {fp(out,"local variable: %s\n",$2);}
        | DATA IDS "[" expr "]" ASSIGN expr ";"   {fp(out,":= \nLocal variable- %s  ",$2);}
        ;
                   
bodies :   begin
          | bodies begin
          ;   
        
arguments : DATA IDS {fp(out,"Ident-main\n");fp(out,"function argument: %s\n",$2);}
           | arguments "," DATA IDS {fp(out,"function argument: %s\nFunction body\n",$4);}
           ;
               

If:  IF "(" expr ")" "{" bodies "}" {fp(out," Ident-if\n");}
         |IF "(" expr ")" "{" bodies "}" ELSE "{" bodies "}"{fp(out,"  Ident-if "); 
         fp(out," Ident-else \n");}
         ;
        
While: WHILE "(" expr ")" "{" bodies "}" {fp(out," Ident-While\n");}
       ; 

expr : expr OP expr        
     | "(" expr ")" 
     | "["expr "]"
     | expr "," expr
     | IDS expr 
     ;
base : IDS {fp(out,"VAR- %s  ",$1);} 
      | NMS  {fp(out," CONST: %d  ",$1);}
      ;     


%%

int yywrap(void) {
 return 1;
}

int main(int argc[],char *argv[]){
yyin=fopen(argv[1],"r");
yyout=fopen("Lexer.txt","w");
out=fopen("Parser.txt","w");
yyparse();

return 0;
}






