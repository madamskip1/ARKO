
 
CC = gcc -g
CFLAGS = -Wall -m64

all: main.o prog.o
	$(CC) $(CFLAGS) -o prog main.o prog.o

prog.o: prog.s prog.h
	nasm -f elf64 -o prog.o prog.s

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c 

clean:
	rm -f *.o

