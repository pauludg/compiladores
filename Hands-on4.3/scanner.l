%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%
"func"                  { return FUNC; }
[0-9]+                  { return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }
"("                     { return PARIZQ; }
")"                     { return PARDER; }
";"                     { return PUNTOYCOMA; }
","                     { return COMA; }
[ \t\n]+                ; // Ignorar espacios en blanco
.                       { return yytext[0]; }
%%


int yywrap(void) {
    return 1;
}
