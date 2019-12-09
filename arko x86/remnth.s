    section.text
    global remnth

remnth:
; prolog
    push ebp
    mov ebp, esp

; procedure
push    ebx
push    edi
push    ecx
push    edx

    mov eax, [ebp+8]; Text in which I'm removing every nth letter
    mov ebx, [ebp+12]; = n
    mov ecx, [ebp+8] ; pointer to next letter


lopext:
    mov edi, ebx    ; edi = n
    dec edi               ; edi =n-1 (when edi==0 exit )
lop1:
    mov dl, [ecx]         ; letter which will be a replacement
    mov byte [eax], dl    ; replace
    test dl,dl            ; was the replacement equal to 0
    je exit               ; if yes that means the procedure is over
    inc eax               ; else increment pointer to letter which will be replaced
    inc ecx               ; increment pointer to letter which is a replacement
    dec edi               ; is it already nth number?
    jnz lop1              ; if not then repeat the loop
    inc ecx               ; else skip that letter by proceeding to the next one
    jmp lopext            ; we need to set counter (edi) once more 

exit:
pop edx
pop ecx
pop edi
pop ebx
mov eax, [ebp+8]
; epilog
                    
        pop ebp     
        ret         