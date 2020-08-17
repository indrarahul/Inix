print_str:
    pusha

start:
    mov al, [bx]
    cmp al, 0
    je end

    mov ah,0x0e
    int 0x10

    add bx, 1
    jmp start

end:
    popa
    call print_newline
    ret


print_newline:
    pusha
    mov ah, 0x0e   
    mov al, 0xa
    int 0x10
    mov al, 0x0d
    int 0x10
    popa
    ret