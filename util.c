#include <stdio.h>
#include <stdlib.h>

#include "util.h"

int running;
int n_line;
int comment_control;

hashtable_t *hashtable;

int yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);

	exit(3);
}

int yywrap()
{
	return 1;
}

void init_me()
{
	running = 1;
	n_line = 0;
	comment_control = 0;
	hashtable = ht_create();
}

int get_line_number()
{
	return n_line;
}

