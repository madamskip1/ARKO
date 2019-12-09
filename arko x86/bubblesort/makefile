CC=gcc
OBJ=main.o bubblesort.o
LINKOBJ=main.o bubblesort.o
BIN=prog
CFLAGS=-m32 -Wall
$(BIN): $(OBJ)
	$(CC) $(LINKOBJ) $(CFLAGS) -o $(BIN)
main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o
bubblesort.o: bubblesort.s
	nasm -f elf bubblesort.s