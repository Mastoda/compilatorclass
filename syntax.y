%token KW_INT
%token KW_REAL
%token KW_BOOL
%token KW_CHAR
%token KW_IF
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

%%

program:
    
    |
    ;

type:
    KW_BOOL     { $$ = "bool"; }
    | KW_CHAR   { $$ = "char"; }
    | KW_INT    { $$ = "int"; }
    | KW_REAL   { $$ = "real"; }
    |
    ;

identifier:
    TK_IDENTIFIER { 
        printf("identifier: [%s] \n", $1); 
        $$ = $1;
    }
    |
    ;

boolean:
    LIT_FALSE   { $$ = "false"; }
    | LIT_TRUE  { $$ = "true"; }
    |
    ;

literal:
    LIT_INTEGER {
        printf("literal: [%s] \n", $1);
        $$ = $1;
    }
    | boolean {
        printf("literal: [%s] \n", $1);
        $$ = $1;
    }
    | LIT_CHAR {
        printf("literal: [%s] \n", $1);
        $$ = $1;
    }
    | LIT_STRING {
        printf("literal: [%s] \n", $1);
        $$ = $1;
    }
    |
    ;

command_block:
    '{' command_sequence '}' {}
    |
    ;

command_sequence:
    |
    ;

commands:
    command_block {}
    | attribution {}
    | input {}
    | output {}
    | return {}
    | if_block {}
    | loop_block {}
    |
    ;

attribution:
    identifier '=' expression {}
    |
    ;

input:
    KW_INPUT identifier {}
    |
    ;

output:
    KW_OUTPUT identifier {}
    |
    ;

return:
    KW_RETURN identifier {}
    |
    ;

global_var:
    type identifier ':' literal ';' {}
    |
    ;

if_block:
    KW_IF '(' expression ')' commands {}
    | if_block KW_ELSE commands {}
    |
    ;

loop_block:
    KW_LOOP '(' expression ')' commands {}
    |
    ;

%%
