    section .text

    global remnth

remnth:
    push rbp
    mov rbp, rsp

    mov r12, 0
    mov r13, rdi
    mov r14, rsi

    mov dl, [r13]
    cmp dl, 0
    jz end

loopA:
    mov dl, [r13]
    cmp dl, 0
    jz endstring


    add r12, 1
    cmp r12, rsi
loopB:
    je reset

    mov [rdi], dl
    inc rdi
    jmp next

reset:
    mov r12, 0
next:
    inc r13
    jmp loopA

endstring:
    mov [rdi], byte 0

end:
    mov rsp, rbp
    pop rbp
    ret     