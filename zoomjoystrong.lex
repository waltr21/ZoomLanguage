%{
  #include <stdio.h>
  #include "zoomjoystrong.tab.h"
%}

%option noyywrap

%%

end {return END;}
; {return END_STATEMENT;}
point {return POINT;}
line {return LINE;}
rectangle {return RECTANGLE;}
circle {return CIRCLE;}
set_color {return SET_COLOR;}

[0-9]+ {yylval.iVal = atoi(yytext); return(INT);}
[0-9]+.\[0-9] { yylval.fVal = atof(yytext); return(FLOAT);}
.|\n {printf("Error!");}

%%
