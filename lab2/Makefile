all: letters
letters: letters.o
	ld letters.o -o letters
letters.o: letters.s
	as letters.s -o letters.o
