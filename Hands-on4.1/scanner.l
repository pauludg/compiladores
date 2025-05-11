%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%
"int"                   { return INT; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }
";"                     { return PUNTOYCOMA; }
[ \t\n]+                ; // Ignorar espacios en blanco
.                       { return yytext[0]; } // Cualquier otro caracter
%%

int yywrap(void) {
    return 1;
}
