#include <stdio.h>
#include <string.h>
#include "hash.h"
#include "util.h"

extern int running;

extern hashtable_t *hashtable;

int yyparse(void);

char tkstr[35][100] = {{0}};

int main(void)
{
	int lex_return;
	init_me();
	yyparse();

	return 0;

}
