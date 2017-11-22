%token KW_INT
%token KW_BOOL
%token KW_CHAR
%token KW_IF
%token KW_THEN
%token KW_ELSE
%token KW_LOOP
%token KW_INPUT
%token KW_RETURN
%token KW_OUTPUT

%token OP_LE
%token OP_GE
%token OP_EQ
%token OP_NE
%token OP_AND
%token OP_OR

%token TK_IDENTIFIER
%token LIT_INTEGER
%token LIT_FALSE
%token LIT_TRUE
%token LIT_CHAR
%token LIT_STRING

%token TOKEN_ERROR

%{
    #include <stdio.h>
    #include "hash.h"
%}

%union {
    char *symbol;
    int integer;
}

%%

program:
    global_var ';' program {}
    | def_func ';' program {}
    |
    ;

/* variables */

global_var:
    type identifier ':' literal {}
    | type identifier '[' LIT_INTEGER ']' {}
    | type identifier '[' LIT_INTEGER ']' ':' array_initializer {}
    | type '$' identifier ':' literal {}
    ;

array_initializer:
    literal array_initializer {}
    |
    ;

/* functions */

def_func:
    header_func command {}
    ;

header_func:
    type identifier '(' header_parameters ')' {}
    | type identifier '(' ')' {}
    ;

header_parameters:
    type identifier {}
    | type identifier ',' header_parameters {}
    ;

/* commands */

command_block:
    '{' command_sequence '}' {}
    | '{' '}' {}
    ;

command_sequence:
    command {}
    | command command_sequence {}
    ;

command:
    command_block {}
    | attribution {}
    | input       {}
    | output      {}
    | return      {}
    | if_block    {}
    | loop_block  {}
    ;

attribution:
    identifier '=' expression {}
    | identifier '[' expression ']' '=' expression {}
    ;

input:
    KW_INPUT identifier {}
    ;

output:
    KW_OUTPUT output_params {}
    ;

output_params:
    LIT_STRING {}
    | LIT_STRING ',' output_params {}
    | expression {}
    | expression ',' output_params {}
    ;

return:
    KW_RETURN expression {}
    ;

operator:
    boolean_operator {}
    | arithmetic_operator {}
    ;

boolean_operator:
    OP_AND  {}
    | OP_EQ {}
    | OP_GE {}
    | OP_LE {}
    | OP_NE {}
    | OP_OR {}
    | '>'   {}
    | '<'   {}
    | '!'   {}
    ;

arithmetic_operator:
    '+' {}
    | '-' {}
    | '*' {}
    | '/' {}
    ;

call_params:
    expression {}
    | expression ',' call_params {}
    |
    ;

unary_operator:
    '&' {}
    | '$' {}
    ;

expression:
    expression operator expression   {}
    | unary_operator expression      {}
    | '(' expression ')'             {}
    | identifier                     {}
    | identifier '(' call_params ')' {}
    | identifier '[' expression ']'  {}
    | LIT_INTEGER                    {}
    | boolean                        {}
    | LIT_CHAR                       {}
;

if_block:
    KW_IF '(' expression ')' KW_THEN command {}
    | KW_IF '(' expression ')' KW_THEN command KW_ELSE command {}
    ;

loop_block:
    KW_LOOP command '(' expression ')' {}
    ;

/* aliases */

type:
    KW_BOOL   {}
    | KW_CHAR {}
    | KW_INT  {}
    ;

identifier:
    TK_IDENTIFIER {}
    ;

boolean:
    LIT_FALSE  {}
    | LIT_TRUE {}
    ;

literal:
    LIT_INTEGER  {}
    | boolean    {}
    | LIT_CHAR   {}
    | LIT_STRING {}
    ;

%%
