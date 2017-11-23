all: util.o  hash.o y.tab.o lex.yy.o scanner.o
	@gcc -m64 -std=c99 -pedantic -Wall -Wshadow -Wpointer-arith -Wcast-qual \
        -Wstrict-prototypes -Wmissing-prototypes util.o main.o lex.yy.o y.tab.o \
	hash.o -L . -o etapa2

util.o: util.c util.h
	@gcc -m64 -std=c99 -pedantic -Wall -Wshadow -Wpointer-arith -Wcast-qual \
        -Wstrict-prototypes -Wmissing-prototypes -c util.c -o util.o

scanner.o: main.c
	@gcc -m64 -std=c99 -pedantic -Wall -Wshadow -Wpointer-arith -Wcast-qual \
        -Wstrict-prototypes -Wmissing-prototypes -c main.c -o main.o

y.tab.o: syntax.y
	@bison syntax.y -d --file-prefix y
	@gcc -c y.tab.c -o y.tab.o

lex.yy.o: scanner.l
	@lex scanner.l
	@gcc -m64 -std=c99 -pedantic -Wall -Wshadow -Wpointer-arith -Wcast-qual \
        -Wstrict-prototypes -Wmissing-prototypes -c lex.yy.c -o lex.yy.o

hash.o: hash.c hash.h
	@gcc -m64 -std=c99 -pedantic -Wall -Wshadow -Wpointer-arith -Wcast-qual \
        -Wstrict-prototypes -Wmissing-prototypes -c hash.c -o hash.o

clean:
	@rm -f lex.yy.* *.o etapa2 y.tab.* 
