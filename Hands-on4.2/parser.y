%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(char *s) { printf("Error: %s\n", s); return 0; }

#define MAX_ID 100
char *tabla[MAX_ID];
int tipos[MAX_ID];
int ntabla = 0;

void agregar_tipo(char *id, int tipo) {
    for (int i = 0; i < ntabla; i++)
        if (strcmp(tabla[i], id) == 0) return;
    tabla[ntabla] = strdup(id);
    tipos[ntabla++] = tipo;
}

int buscar_tipo(char *id) {
    for (int i = 0; i < ntabla; i++)
        if (strcmp(tabla[i], id) == 0) return tipos[i];
    return -1;
}

int existe(char *id) {
    for (int i = 0; i < ntabla; i++)
        if (strcmp(tabla[i], id) == 0) return 1;
    return 0;
}
%}

%union {
    char *str;
}

%token <str> ID
%token INT IGUAL PUNTOYCOMA

%%
programa:
    declaraciones asignaciones
;

declaraciones:
    INT ID PUNTOYCOMA               { agregar_tipo($2, 0); }
  | declaraciones INT ID PUNTOYCOMA { agregar_tipo($3, 0); }
;

asignaciones:
    ID IGUAL ID PUNTOYCOMA {
        if (!existe($1) || !existe($3))
            printf("Error: identificador no declarado\n");
        else if (buscar_tipo($1) != buscar_tipo($3))
            printf("Error: tipos incompatibles\n");
    }
  | asignaciones ID IGUAL ID PUNTOYCOMA {
        if (!existe($2) || !existe($4))
            printf("Error: identificador no declarado\n");
        else if (buscar_tipo($2) != buscar_tipo($4))
            printf("Error: tipos incompatibles\n");
    }
;
%%

int main() {
    return yyparse();
}
