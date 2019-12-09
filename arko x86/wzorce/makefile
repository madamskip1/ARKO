CC=gcc
OBJ=main.o wzorce.o
LINKOBJ=main.o wzorce.o
BIN=prog
CFLAGS=-m32 -Wall
$(BIN): $(OBJ)
	$(CC) $(LINKOBJ) $(CFLAGS) -o $(BIN)
main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o
wzorce.o: wzorce.s
	nasm -f elf wzorce.s