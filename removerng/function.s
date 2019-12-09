    section .text
    global function

function:
    push rbp
    mov rbp, rsp

    ; rdi   string
    ; sil   a
    ; dl    b

    mov r12, rdi
    mov cl, [r12]
    cmp cl, 0
    jz end

loopA:
    mov cl, [r12]
    cmp cl, 0
    jz endstring

    cmp cl, sil
    jl moveChar
    cmp cl, dl
    jg moveChar

    inc r12
    jmp loopA

moveChar:
    mov [rdi], cl
    inc r12
    inc rdi
    jmp loopA


endstring:
    mov [rdi], byte 0

end:
    mov rsp, rbp
    pop rbp
    ret