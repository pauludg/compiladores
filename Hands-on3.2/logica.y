%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(char *s);
%}

%token BOOLEAN AND OR NOT

%%

input:
      /* permite multiples expresiones */
    | input expr '\n'    { printf("Expresion valida\n"); }
    | input error '\n'   { yyerror("Expresion invalida"); yyerrok; }
    ;

expr:
      expr AND term
    | expr OR term
    | term
    ;

term:
      NOT factor
    | factor
    ;

factor:
      '(' expr ')'
    | BOOLEAN
    ;

%%

int main(void) {
    return yyparse();
}

int yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}
