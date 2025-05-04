%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUM
%token AND OR NOT

%left OR
%left AND
%left '+' '-'
%left '*' '/'
%right NOT

%%

input:
      /* permite multiples expresiones */
    | input expr '\n'    { printf("Expresion valida\n"); }
    | input error '\n'   { yyerror("Expresion invalida"); yyerrok; }
    ;

expr:
    expr '+' term
  | expr '-' term
  | term
;

term:
    term '*' factor
  | term '/' factor
  | factor
;

factor:
    '(' expr ')'
  | logical
;

logical:
    logical AND logical
  | logical OR logical
  | NOT logical
  | NUM
;

%%

void yyerror(const char *s) {
    printf("Expresion invalida\n");
}

int main(void) {
    return yyparse();
}
