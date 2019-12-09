    section .text
    global function

function:
    push rbp
    mov rbp, rsp

    ; rdi   string
    ; rsi   n

    mov r12, 0
    mov r13, rdi
    mov dl, [r13]
    cmp dl, 0
    jz end

loopA:
    mov dl, [r13]
    cmp dl, 0
    jz go

    add r12, 1
    inc r13
    jmp loopA


go:
    sub r12, rsi
    mov r14, 0
    
loopB:
    add r14, 1
    cmp r14, r12
    jg endstring

    inc rdi
    jmp loopB



endstring:
    mov [rdi], byte 0

end:
    mov rsp, rbp
    pop rbp
    ret