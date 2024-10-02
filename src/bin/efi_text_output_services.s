clearScreen:
    mov  rax, [systemTable]
    mov  rax, [rax + EFI_SYSTEM_TABLE.ConOut]

    mov  rcx, [rax + EFI_SYSTEM_TABLE.ConOut]

    call [rax + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.ClearScreen]

    cmp  rax, EFI_SUCCESS
    jne  textOutputError
    ret

outputString:    
    mov  rdx, rcx
    mov  rcx, [systemTable]
    mov  rcx, [rax + EFI_SYSTEM_TABLE.ConOut]

    call [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString]

    cmp  rax, EFI_SUCCESS
    jne  textOutputError
    ret

textOutputError:
    hlt
    jmp textOutputError