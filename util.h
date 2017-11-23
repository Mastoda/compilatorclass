#ifndef _UTIL_H
#define _UTIL_H

#include "hash.h"

extern int running;
extern int n_line;
extern int comment_control;

extern hashtable_t *hashtable;

void init_me();

int yyerror();
int get_line_number();

#endif
