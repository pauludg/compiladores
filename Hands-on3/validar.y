%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(char *s);
%}
%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS
%%
input:
    | input line
    ;

line:
    expr '\n' { printf("Expresion valida\n"); }
  | '\n'
  | error '\n' { yyerror("Expresion invalida"); yyerrok; }
  ;


expr: expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '-' expr %prec UMINUS
    | '(' expr ')'
    | NUMBER
    ;
%%
int yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}
int main(void) {
    return yyparse();
}

