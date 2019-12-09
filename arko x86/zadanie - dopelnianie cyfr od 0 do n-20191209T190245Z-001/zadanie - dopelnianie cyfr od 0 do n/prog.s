    section.text
    global dop

dop:
; prolog
    push ebp
    mov ebp, esp

; procedure
push    ebx
push    edi
push    ecx
push    edx

    mov eax, [ebp+8]
    mov bl, [ebp+12]; = n
    add  bl,'0'        ; zamieniam n na kod ascii
lop1:
    
    mov dl, [eax] 
    test dl,dl
    je exit

    cmp dl,bl            ; czy dana litera mniejsza lub wieksza? od n?
    ja  proceed           ; jezeli wieksza to idz dalej
    cmp dl,'0'            ; czy mniejsza od 0?
    jb  proceed
                    ; tutaj znak jest z przedzialu 0-n
    sub dl,'0'
    mov cl, bl
    sub cl, dl
    mov byte [eax], cl
proceed:
    inc eax
    jmp lop1


exit:
pop edx
pop ecx
pop edi
pop ebx
mov eax, [ebp+8]
; epilog
                    
        pop ebp     
        ret         