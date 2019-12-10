    section .text
    global function

function:
    push rbp
    mov rbp, rsp

    ; rdi   string


    mov dl, [rdi]
    cmp dl, 0
    jz end
    dec rdi

loopA:
inc rdi
    mov dl, [rdi]
    cmp dl, 0
    jz end

first:
    cmp dl, 90
    jle second

    sub dl, 32
    mov [rdi], dl

second:

    inc rdi
    mov dl, [rdi]

    cmp dl, 97
    jge third

    add dl, 32
    mov [rdi], dl

third:
    inc rdi

fourth: 
    inc rdi

    mov dl, [rdi]

    cmp dl, 97
    jge loopA

    add dl, 32
    mov [rdi], dl

    jmp loopA

end:
    mov rsp, rbp
    pop rbp
    ret