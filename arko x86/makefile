OBJ=main.o remnth.o
LINKOBJ=main.o remnth.o
BIN=prog
CFLAGS=-m32 -Wall
$(BIN): $(OBJ)
	$(CC) $(LINKOBJ) $(CFLAGS) -o $(BIN)
main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o
remnth.o: remnth.s
	nasm -f elf32 remnth.s