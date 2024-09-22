
MEMORY_START equ 0x7C00

org MEMORY_START
bits 16

%define ENDL 0x0D, 0x0A

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

    mov ah, 0x0E
    mov bh, 0
    int 0x10
    jmp .puts_loop

return:
    popa
    ret

times 510-($-$$) db 0
dw 0AA55h