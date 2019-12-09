all: asm
	gcc -m32 zmiana_asm.o zmiana.c -o zmiana
asm:
	nasm -f elf zmiana.asm -o zmiana_asm.o

szukaj1 : asm_szukaj1
	gcc -m32 szukaj1_asm.o szukaj1.c -o szukaj1
asm_szukaj1:
	nasm -f elf szukaj1.asm -o szukaj1_asm.o

szukaj2 : asm_szukaj2
	gcc -m32 szukaj2_asm.o	szukaj2.c -o szukaj2
asm_szukaj2:
	nasm -f elf szukaj2.asm -o szukaj2_asm.o
