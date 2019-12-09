section .text

global szukaj2

szukaj2:
  
   	push ebp
   	mov ebp, esp
    
	mov eax, [ebp + 8]	;ten w ktorym szukam
	mov ebx, [ebp + 12]	;ten ktorego szukam
	mov edx, [ebp + 12]
	
COMPARE:
	cmp byte [eax], 0
	je NIESUKCES
	cmp byte [ebx], '*' 
	je GWIAZDA
	mov cl, [ebx]
	cmp [eax], cl
	je ROWNE
	jmp SKIP
	
GWIAZDA:
	inc ebx
	cmp byte [ebx], 0
	je SUKCES
	mov edx, ebx
	jmp COMPARE

ROWNE:
	inc ebx
	inc eax
	cmp byte [ebx], 0
	je SUKCES
	jmp COMPARE
	

SKIP:
	inc eax
	mov ebx, edx
	jmp COMPARE
   
SUKCES:
	mov eax, 1
	jmp KONIEC

NIESUKCES:
	mov eax, 0

KONIEC:
	mov esp, ebp
	pop ebp
	ret
