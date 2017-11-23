%{
	#include "hash.h"
	#include "util.h"
	#include "symbols.h"
	#include "y.tab.h"

	int running;
	int n_line;
	char buffer[1024];
	char *s;
	hashtable_t *hashtable;

%}

%x STRING
%x COMMENT_BLOCK 

%%

[ \t]	;
\n	n_line++;
	
	/* operators */
[,;:()-/<>=!&\{\}\[\]\+\*\$] { return yytext[0]; }

\<=		return OP_LE;
>=		return OP_GE;
==		return OP_EQ;
!=		return OP_NE;
&&		return OP_AND;
\|\|	return OP_OR;

	/* keywords */
int		return KW_INT;
bool	return KW_BOOL;
char	return KW_CHAR;
if		return KW_IF;
then	return KW_THEN;
else	return KW_ELSE;
loop	return KW_LOOP;
input	return KW_INPUT;
return	return KW_RETURN;
output	return KW_OUTPUT;

	/* literals */

	/* booleans */
false { 
	yylval.symbol = ht_set(hashtable, yytext, SYMBOL_LIT_FALSE);
	return LIT_FALSE;
}
true { 
	yylval.symbol = ht_set(hashtable, yytext, SYMBOL_LIT_TRUE); 
	return LIT_TRUE; 
}

	/* integers */
[0-9]* { 
	yylval.symbol = ht_set(hashtable, yytext, SYMBOL_LIT_INTEGER); 
	return LIT_INTEGER; 
}

	/* characters */
'.' {
	char aux[2]; 
	aux[0] = yytext[1]; 
	aux[1] = '\0'; 
	yylval.symbol = ht_set(hashtable, aux, SYMBOL_LIT_CHAR);
	return LIT_CHAR; 
}

	/* identifiers */
[a-zA-Z]+[a-zA-Z_]* {
	yylval.symbol = ht_set(hashtable, yytext, SYMBOL_IDENTIFIER); 
	return TK_IDENTIFIER; 
}

	/* string rules */
\" { BEGIN STRING; s = buffer; }
<STRING>\\n	{ *s++ = '\n'; }
<STRING>\\t	{ *s++ = '\t'; }
<STRING>\\\" { *s++ = '\"'; }
<STRING>\" { 
	*s++ = '\0'; 
	*s = 0; 
	yylval.symbol = ht_set(hashtable, buffer, SYMBOL_LIT_STRING); 
	BEGIN 0; 
	return LIT_STRING; 
}
<STRING>\n	{ n_line++; *s++ = '\n';}
<STRING>.	{ *s++ = yytext[0]; }

	/* comments rules */
\/\/.*	{}
"/*"			{ BEGIN COMMENT_BLOCK; }
<COMMENT_BLOCK>"*/"	{ BEGIN 0; }
<COMMENT_BLOCK>\n	{ n_line++; }
<COMMENT_BLOCK>.	{}

<<EOF>> exit(0);

.	return TOKEN_ERROR;

%%

