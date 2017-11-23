#include <stdio.h>
#include <string.h>

#include "hash.h"
#include "util.h"

extern hashtable_t *hashtable;
extern int running;
extern FILE *yyin;

int yyparse(void);

char tkstr[35][100] = {{0}};

int main(int argn, char *args[])
{
	int lex_return;

	if (argn > 1)
		yyin = fopen(args[1], "r");

	init_me();
	yyparse();

	return 0;

}
