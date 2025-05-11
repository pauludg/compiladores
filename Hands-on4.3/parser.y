%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(char *s) { printf("Error: %s\n", s); return 0; }

#define MAX_FUNC 100
char *funciones[MAX_FUNC];
int aridades[MAX_FUNC];
int nfuncs = 0;

void registrar_funcion(char *id, int n) {
    funciones[nfuncs] = strdup(id);
    aridades[nfuncs++] = n;
}

int obtener_aridad(char *id) {
    for (int i = 0; i < nfuncs; i++)
        if (strcmp(funciones[i], id) == 0)
            return aridades[i];
    return -1;
}
%}

%union {
    char *str;
    int num;
}

%token <str> ID
%token NUM
%token FUNC PARIZQ PARDER PUNTOYCOMA COMA

%type <num> lista args argumento

%%

programa:
    declaraciones llamadas
;

declaraciones:
    FUNC ID PARIZQ lista PARDER PUNTOYCOMA { registrar_funcion($2, $4); }
  | declaraciones FUNC ID PARIZQ lista PARDER PUNTOYCOMA { registrar_funcion($3, $5); }
;

lista:
    ID { $$ = 1; }
  | lista COMA ID { $$ = $1 + 1; }
;

llamadas:
    ID PARIZQ args PARDER PUNTOYCOMA {
        int n = obtener_aridad($1);
        if (n != $3)
            printf("Error: se esperaban %d argumentos en '%s'\n", n, $1);
    }
  | llamadas ID PARIZQ args PARDER PUNTOYCOMA {
        int n = obtener_aridad($2);
        if (n != $4)
            printf("Error: se esperaban %d argumentos en '%s'\n", n, $2);
    }
;

args:
    argumento { $$ = 1; }
  | args COMA argumento { $$ = $1 + 1; }
  | /* vacio */ { $$ = 0; }
;

argumento:
    ID
  | NUM
;

%%

int main() {
    return yyparse();
}
