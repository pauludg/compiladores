%option yylineno
%{
#include "parser.tab.h"
#include <string.h>
%}

%% 
// Comentarios de una línea
"//"[^'\n']*   ; // Comentarios de una línea

/* Comentarios de múltiples líneas */
"/*"([^*]|\*+[^*/])*\*+"/"    ; // Comentarios multilinea

"int"           { return INT; }
"func"          { return FUNC; }
"return"        { return RETURN; }

"("             { return PARIZQ; }
")"             { return PARDER; }
"{"             { return LLAVEIZQ; }
"}"             { return LLAVEDER; }
","             { return COMA; }
";"             { return PUNTOYCOMA; }
"="             { return IGUAL; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }

[ \t\r\n]+      ;       // Ignorar espacios, tabs, saltos de linea
.               { printf("Caracter inesperado: %s\n", yytext); return -1; }

%% 
int yywrap() { return 1; }
