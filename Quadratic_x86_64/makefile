CC = gcc
CFLAGS = -Wall -m64

all: main.o quadratic.o
	$(CC) $(CFLAGS) -o quadratic main.o quadratic.o `allegro-config --shared`

quadratic.o: quadratic.s
	nasm -f elf64 -o quadratic.o quadratic.s

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c

clean:
	rm -f *.o
	rm quadratic
