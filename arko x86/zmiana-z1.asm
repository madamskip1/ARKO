section .text

global zmiana

zmiana:
  
   	push ebp
   	mov ebp, esp
    
	mov eax, [ebp+8]
	
COMPARE:
	;mov bl, [eax]
	cmp byte [eax], 0
	je KONIEC
	cmp byte [eax], 'A'
	jb SKIP
	cmp byte [eax], 'Z'
	ja DUZE
	add byte [eax], 32
	jmp SKIP

DUZE:
	cmp byte [eax], 'a'
	jb SKIP
	cmp byte [eax], 'z'
	ja SKIP
	sub byte [eax], 32

SKIP:
	inc eax
	jmp COMPARE
   

KONIEC:
	mov eax, [ebp + 8]
	mov esp, ebp
	pop ebp
	ret
