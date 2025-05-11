%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%
"int"           { return INT; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.str = strdup(yytext); return ID; }
"="             { return IGUAL; }
";"             { return PUNTOYCOMA; }
[ \t\n]+        ; // ignorar espacios
.               { return yytext[0]; }
%%


int yywrap(void) {
    return 1;
}
