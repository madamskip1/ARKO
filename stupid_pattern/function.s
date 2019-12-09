    section .text
    global function

function:
    push rbp
    mov rbp, rsp

    ; rdi   string

    mov r13, rdi
    mov dl, [r13]
    cmp dl, 0
    jz end

loopA:
    mov dl, [r13]
    cmp dl, 0
    jz endstring

    cmp dl, 48
    jl writeChar

    cmp dl, 57
    jg writeChar

    test dl, 1
    jnz writeChar

    jmp next

writeChar:
    mov [rdi], dl
    inc rdi


next:
    inc r13
    jmp loopA




endstring:
    mov [rdi], byte 0

end:
    mov rsp, rbp
    pop rbp
    ret