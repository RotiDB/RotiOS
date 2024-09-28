bits 64

verifySignature:
        mov rax, [ptrSystemTable]
        mov rax, [rax + EFI_SYSTEM_TABLE.Hdr + EFI_TABLE_HEADER.Signature]

        mov rbx, EFI_SYSTEM_TABLE_SIGNATURE
        EFI_ERROR rcx, 1
        cmp rcx, rax
        jne error

        mov rcx, EFI_SUCCESS

        ret

getMemoryMap:
        mov rax, [ptrSystemTable]
        mov rax, [rax + EFI_SYSTEM_TABLE.BootServices]
        lea r8, [bufMemoryMap]
        lea r9, [ptrMemoryMapKey]

        call [rax + EFI_BOOT_SERVICES.GetMemoryMap]

        cmp rax, EFI_SUCCESS
        jne error

locateProtocol:
        mov rax, [ptrSystemTable]
        mov rax, [rax + EFI_SYSTEM_TABLE.BootServices]

        mov rbx, EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID

        mov rcx, 0
        lea r8, [ptrInterface]

        call [rax + EFI_BOOT_SERVICES.LocateProtocol]
        
        cmp rax, EFI_SUCCESS
        jne error

        ret

exitBootServices:
        mov rax, [ptrSystemTable]
        mov rax, [rax + EFI_SYSTEM_TABLE.BootServices]

        mov rcx, [imageHandle]
        mov rdx, [ptrMemoryMapKey]

        call [rax + EFI_BOOT_SERVICES.ExitBootServices]

        cmp rax, EFI_SUCCESS
        jne error

error:
        hlt
        jmp error