; load DH sectors to ES:BX from drive DL

disk_load :
    push dx ; Store DX on stack so later we can recall
    ; how many sectors were request to be read ,

    mov ah , 0x02 ; BIOS read sector function
    mov al , dh   ; Read DH sectors
    mov ch , 0x00 ; Cylinder 0
    mov dh , 0x00 ; Head 0
    mov cl , 0x02 ; Second Sector (After the boot sector)
    int 0x13 

    jc disk_error ; Error ( Carry Flag Set )

    pop dx 
    cmp dh , al ; Sectors Read != Sectors Expected
    jne disk_error 
    ret

disk_error :
    mov bx , DISK_ERROR_MSG
    call print_str
    jmp $

DISK_ERROR_MSG db "Disk read error !" , 0