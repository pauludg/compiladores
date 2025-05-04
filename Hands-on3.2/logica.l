%{
#include "logica.tab.h"
%}

%%

[ \t\r]+         ;               // ignorar espacios
"AND"            { return AND; }
"OR"             { return OR; }
"NOT"            { return NOT; }
"0"|"1"          { return BOOLEAN; }
"("              { return '('; }
")"              { return ')'; }
\n               { return '\n'; }

.                { return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}
