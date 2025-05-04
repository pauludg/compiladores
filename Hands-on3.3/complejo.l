%{
#include "complejo.tab.h"
#include <stdlib.h>
%}

AND     "AND"
OR      "OR"
NOT     "NOT"

%%

[0-9]+              { yylval = atoi(yytext); return NUM; }
{AND}               { return AND; }
{OR}                { return OR; }
{NOT}               { return NOT; }
[ \t\r]+            { /* ignorar espacios */ }
\n                  { return '\n'; }
.                   { return yytext[0]; }

%%

int yywrap(void) { return 1; }
