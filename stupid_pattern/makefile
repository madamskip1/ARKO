CC = gcc -g
CFLAGS = -Wall -m64

all: main.o function.o
	$(CC) $(CFLAGS) -o function main.o function.o

function.o: function.s function.h
	nasm -f elf64 -o function.o function.s

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c 

clean:
	rm -f *.o