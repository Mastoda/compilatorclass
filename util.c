#include <stdio.h>
#include <stdlib.h>
#include "util.h"

int running;
int n_line;
int comment_control;

hashtable_t *hashtable;

int yywrap(void)
{
	return 1;
}

int yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);

	exit(3);
}

int get_line_number(void)
{
	return n_line;
}

void init_me(void)
{
	running = 1;
	n_line = 0;
	comment_control = 0;
	hashtable = ht_create();
}
