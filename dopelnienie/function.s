    section .text

    global function

function:
    push rbp
    mov rbp, rsp

    ;rdi string
    ;rsi n

    ;add rsi, 48
    add rsi, '0'

    dec rdi

loopA:
    inc rdi
    mov dl, [rdi]
    cmp dl, 0
    jz end

    cmp dl, 48
    jl loopA

    cmp dl, 57
    jg loopA

    mov cl, dl
    sub cl, sil

    cmp cl, 0
    jg loopA

    neg cl
    add cl, 48
    mov [rdi], cl
    jmp loopA


end:
    mov rsp, rbp
    pop rbp
    ret     