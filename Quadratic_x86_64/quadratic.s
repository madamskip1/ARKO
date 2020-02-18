
; rsi - size
; rdx - scale

; xmm0 - A coef
; xmm1 - B coef
; xmm2 - C coef
; xmm3 - S^2 coef


	section .text
	global quadratic

quadratic:
	push rbp
	mov rbp, rsp
	mov r8, rsi
	mov r9, rsi

    xor rax, rax
    mov r13, rax 
	mov r12, r13
    dec rax

	cvtsi2sd xmm6, rax ; Przesuniecie na srodek ukladu


	mov r15, rsi

loopA:
    xor rax, rax
    mov eax, 1
	cvtsi2sd xmm12, rax 
    xor rax, rax
    mov eax, esi
	sar eax, 1

	cvtsi2sd xmm11, rax
    divsd xmm12, xmm11 ; xmm12 = 1 / scale
	addsd xmm6, xmm12


	movsd xmm4, xmm6 ; xmm4 -> x
	
	; calc  xmm4 -> y = A*x^2
	mulsd xmm4, xmm4 
	mulsd xmm4, xmm0 
	
	; calc  xmm5 -> B*x
	movsd xmm5, xmm6
	mulsd xmm5, xmm1

	; calc  xmm4 -> y = A*x^2 + B*x + C
	addsd xmm4, xmm5 
	addsd xmm4, xmm2
	
	add r12, 1
	cmp r12, r15
	jg end

	movsd xmm9, xmm4 ; xmm9 = Y
	subsd xmm9, xmm7 
	mulsd xmm9, xmm9 ; xmm9 = dy^2

	movsd xmm10, xmm6 ; xmm10 = X
	subsd xmm10, xmm8
	mulsd xmm10, xmm10 ; xmm10 = dx^2
	
	addsd xmm9, xmm10 ; xmm9 = dx^2 + dy^2
	
	comisd xmm9, xmm3 
	jnae loopA

drawPoint:
	cvtsi2sd xmm11, rdx   ; xmm11 = scale

    movsd xmm5, xmm4
	mulsd xmm5, xmm11  ; xmm5 = Y * scale
	cvtsd2si r10, xmm5

    xor rbx, rbx

    mov ebx, esi
	sar ebx, 1

	add r10, rbx

	cmp r10, r15 
	jg loopA

	cmp r10, 1
	jl loopA

	; calc pixel adress
	mov r11, rdi
	mov r8, rsi
	sub r8, r10
	shl r8, 3  
	add r11, r8
	
	mov rbx, [r11]  ; rbx => pixel do kolorwania
	add rbx, r12

	
	mov al, 255    ; al - color 
	mov [rbx], al  ; kolorownie
	
	movsd xmm7, xmm4 
	movsd xmm8, xmm6
	
	mov r13, r12
	
	jmp loopA


end:	
	mov rsp, rbp	
	pop rbp
	ret


