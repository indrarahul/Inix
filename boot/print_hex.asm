print_hex:
    pusha
    mov cx,0

loop_:
    cmp cx, 4
    je end2

    mov ax,dx
    and ax, 0x000f
    add al, 0x30
    cmp al, 0x39
    jle s2
    add al, 7


s2:
    mov bx, HEX_STR + 5
    sub bx, cx
    mov [bx],al
    ror dx, 4
    
    add cx,1
    jmp loop_

end2:
    mov bx,HEX_STR
    call print_str
    popa
    ret

HEX_STR:
    db '0x0000',0
