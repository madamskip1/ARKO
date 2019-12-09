CC = gcc -g
CFLAGS = -Wall -m64

all: main.o remnth.o
	$(CC) $(CFLAGS) -o remtnh main.o remnth.o

remnth.o: remnth.s
	nasm -f elf64 -o remnth.o remnth.s

main.o: main.c 
	$(CC) $(CFLAGS) -c -o main.o main.c 

clean:
	rm -f *.o