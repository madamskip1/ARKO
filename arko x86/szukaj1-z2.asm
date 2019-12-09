section .text

global szukaj1

szukaj1:
  
   	push ebp
   	mov ebp, esp
    
	mov eax, [ebp + 8]	;ten w ktorym szukam
	mov ebx, [ebp + 12]	;ten ktorego szukam
	mov dl, 0	

	cmp byte [ebx], '.'
	jne COMPARE
	mov edx, [ebp + 8]
	
COMPARE:
	cmp byte [eax], 0
	je NIESUKCES
	cmp byte [ebx], '.' 
	je ROWNE
	mov cl, [ebx]
	cmp byte [eax], cl
	je ROWNE
	jmp KROPA
	
ROWNE:
	inc ebx
	inc eax
	cmp byte [ebx], 0
	je SUKCES
	jmp COMPARE
	
KROPA:
	cmp dl, 0
	je SKIP
	mov eax, edx
	inc edx

SKIP:
	inc eax
	mov ebx, [ebp + 12]
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
