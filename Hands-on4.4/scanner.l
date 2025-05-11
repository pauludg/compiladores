%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"int"              { return INT; }
"{"                { return LLAVEIZQ; }
"}"                { return LLAVEDER; }
";"                { return PUNTOYCOMA; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }

[ \t\n\r]+         ;  // Ignorar espacios en blanco

.                  { return yytext[0]; }

%%



int yywrap(void) {
    return 1;
}
