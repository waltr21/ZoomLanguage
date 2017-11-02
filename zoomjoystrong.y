%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "zoomjoystrong.h"
  void yyerror(const char* msg) {
          fprintf(stderr, "%s on line no: %d\n", msg);
          //yyerror;
    }
  int yyflex();
  int makeColorValid();
  int makeValid();
%}

%union{
  int iVal;
  float fVal;
  char* sval;
}

// Now, we provide the type information
// for our tokens (tokens are defined in)
// our Flex file.  We want the value to be
// stored from Flex in the proper data
// structure.
%start program

%token <iVal> INT
%token <fVal> FLOAT
%token <sVal> VAR

%token  END
%token  END_STATEMENT
%token  POINT
%token  LINE
%token  CIRCLE
%token  RECTANGLE
%token  SET_COLOR

%%

program:        statement_list end_program;

statement_list: statement
              | statement statement_list
              ;

statement:      POINT INT INT END_STATEMENT {point(makeValid($2), makeValid($3));}
          |     LINE INT INT INT INT END_STATEMENT {line(makeValid($2), makeValid($3), makeValid($4), makeValid($5));}
          |     CIRCLE INT INT INT END_STATEMENT {circle(makeValid($2), makeValid($3), makeValid($4));}
          |     RECTANGLE INT INT INT INT END_STATEMENT {rectangle(makeValid($2), makeValid($3), makeValid($4), makeValid($5));}
          |     SET_COLOR INT INT INT END_STATEMENT {set_color(makeColorValid($2),makeColorValid($3),makeColorValid($4));}
	  ;

end_program: END END_STATEMENT {finish();};

%%

int main(int argc, char** argv){
    setup();
    yyparse();
    return 0;
}

int makeColorValid(int num){
    if (num > 255){
	num = 1;
	printf("Not a valid color number... Setting to 1\n");
    }
    return num;
}

int makeValid(int num){
   if (num < 0){
	printf("Not a valid number... Setting to 0\n");
	num = 0;
   }   
   return num;
}
