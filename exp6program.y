%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(char *s);
%}

%define api.value.type {double}

%token NUM

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

statement:
      expression '\n'
        {
            printf("Answer: %g\n", $1);
        }
    ;

expression:
      expression '+' expression
        {
            $$ = $1 + $3;
        }

    | expression '-' expression
        {
            $$ = $1 - $3;
        }

    | expression '*' expression
        {
            $$ = $1 * $3;
        }

    | expression '/' expression
        {
            if ($3 == 0)
            {
                printf("Error: Division by zero\n");
                YYERROR;
            }

            $$ = $1 / $3;
        }

    | '-' expression %prec UMINUS
        {
            $$ = -$2;
        }

    | '(' expression ')'
        {
            $$ = $2;
        }

    | NUM
        {
            $$ = $1;
        }
    ;

%%

int main()
{
    printf("Enter the expression:\n");

    yyparse();

    return 0;
}

int yyerror(char *s)
{
    printf("Invalid expression: %s\n", s);
    return 0;
}
