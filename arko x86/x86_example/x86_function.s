	section .text
	
	global x86_function

x86_function:
	push rbp	; push "calling procedure" frame pointer
	mov rbp, rsp	; set new frame pointer 
			;	- "this procedure" frame pointer

;------------------------------------------------------------------------------

	mov rsi, rdi	; save copy of string begin pointer

;------------------------------------------------------------------------------
			; look for the string end (null character == '\0' == 0)
			;	 (NOT zero character == '0')
	
	mov dl, [rdi]	; load byte
	cmp dl, 0	; cmp will set ZERO flag if dl is zero
	jz end		; jump to end because the string is 
			;	empty (first byte is zero!)
loop_1:
	inc rdi		; move to the next byte
	mov dl, [rdi]
	cmp dl, 0
	jnz loop_1	; now RDI points to the terminating byte of the string 
			;	- one byte beyond the last 'visible' character
	
	
	dec rsi		; RSI is moved before the first characterof the string 
			; 	- it will not cause a "segmentation violation" 
			; 	fault, if the program does access this memory  
			;	address. It will be incremented in the next 
			;	instruction. (This is done to simplify the 
			;	following algorithm.)

;------------------------------------------------------------------------------
	
loop_2:			; outer loop - exchanges two numbers
loop_2_A:		; inner loop A - looks for a number from the beginning
	inc rsi		; RSI moves forward from the beginning
	cmp rsi, rdi	; compare if pointers haven`t met yet
	jge end
	mov al, [rsi]	; load byte
	cmp al, '0'
	jl loop_2_A
	cmp al, '9'
	jg loop_2_A	; check if the loaded byte is a number
	
loop_2_B:		; inner loop B - looks for a number from the end
	dec rdi		; RDI goes backward from the end
	cmp rsi, rdi	; rest of the loop is the same as previous loop
	jge end
	mov dl, [rdi]
	cmp dl, '0'
	jl loop_2_B
	cmp dl, '9'
	jg loop_2_B
	
	mov [rdi], al	; exchange loaded bytes - store them to memory
	mov [rsi], dl
	
	jmp loop_2
	
end:

;------------------------------------------------------------------------------

	mov rsp, rbp	; restore original stack pointer
	pop rbp		; restore "calling procedure" frame pointer
	ret

