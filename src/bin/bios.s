MEMORY_START equ 0x7C00

org MEMORY_START
bits 16

%define ENDL 0xD, 0xA

msg: db 'Hello World', ENDL, 0

start:
    and ax, 0
    mov ds, ax
    mov es, ax

    mov ss, ax
    mov sp, MEMORY_START 

    mov si, msg
    call puts

.halt:
    jmp .halt

puts:
    pusha

.puts_loop:
    lodsb
    or al, al
    jz return

    mov ah, 0xE
    mov bh, 0
    int 0x10
    jmp .puts_loop

return:
    popa
    ret

times 510-($-$$) db 0
dw 0xAA55