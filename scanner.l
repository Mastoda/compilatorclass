%{
	#include "y.tab.h"
	#include "hash.h"
	#include "util.h"

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

[,;:()-/<>=!&\{\}\[\]\+\*\$] { 
		yylval = yytext;
		return yytext[0];
}

\<=		return OP_LE;
>=		return OP_GE;
==		return OP_EQ;
!=		return OP_NE;
&&		return OP_AND;
\|\|	return OP_OR;

int		return KW_INT;
real	return KW_REAL;
bool	return KW_BOOL;
char	return KW_CHAR;
if		return KW_IF;
else	return KW_ELSE;
loop	return KW_LOOP;
input	return KW_INPUT;
return	return KW_RETURN;
output	return KW_OUTPUT;

false { 
	yylval = yytext;
	ht_set(hashtable, yytext, LIT_FALSE);
	return LIT_FALSE;
}
true { 
	yylval = yytext; 
	ht_set(hashtable, yytext, LIT_TRUE); 
	return LIT_TRUE; 
}

[0-9]* { 
	yylval = yytext; 
	ht_set(hashtable, yytext, LIT_INTEGER); 
	return LIT_INTEGER; 
}

'.' { 
	yylval = yytext; 
	char aux[2]; 
	aux[0] = yytext[1]; 
	aux[1] = '\0'; 
	ht_set(hashtable, aux, LIT_CHAR); return LIT_CHAR; 
}

[a-zA-Z]+[a-zA-Z_]* { 
	yylval = yytext; 
	ht_set(hashtable, yytext, TK_IDENTIFIER); 
	return TK_IDENTIFIER; 
}

\"		{ BEGIN STRING; s = buffer; }
<STRING>\\n	{ *s++ = '\n'; }
<STRING>\\t	{ *s++ = '\t'; }
<STRING>\\\" { *s++ = '\"'; }
<STRING>\" { 
	*s++ = '\0'; 
	*s = 0; 
	ht_set(hashtable, buffer, LIT_STRING); 
	BEGIN 0; 
	return LIT_STRING; 
}
<STRING>\n	{ n_line++; *s++ = '\n';}
<STRING>.	{ *s++ = yytext[0]; }

\/\/.*	{}
"/*"			{ BEGIN COMMENT_BLOCK; }
<COMMENT_BLOCK>"*/"	{ BEGIN 0; }
<COMMENT_BLOCK>\n	{ n_line++; }
<COMMENT_BLOCK>.	{}

<<EOF>> { running = 0; return running; }

.	return TOKEN_ERROR;

%%

