#ifndef _UTIL
#define _UTIL

#include "hash.h"

extern int running;
extern int n_line;
extern int comment_control;

extern hashtable_t *hashtable;

int yywrap(void);
int yyerror(void);
int get_line_number(void);
void init_me(void);

#endif
