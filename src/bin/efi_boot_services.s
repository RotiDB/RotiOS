locateProtocol:
        mov  rax, [systemTable]
        mov  rax, [rax + EFI_SYSTEM_TABLE.BootServices]
        
        mov  rcx, EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID
        mov  rdx, 0
        lea  r8, [ptrInterface]

        call [rax + EFI_BOOT_SERVICES.LocateProtocol]        
        
        cmp  rax, EFI_SUCCESS
        jne  bootServiceError

        ret

getMemoryMap:
        mov  rax, [systemTable]
        mov  rax, [rax + EFI_SYSTEM_TABLE.BootServices]
 
        lea  rcx, [memoryMapSize]
        lea  rdx, [memoryMap]
        lea  r8,  [mapKey]
        lea  r9,  [descriptorSize]
        lea  r10, [descriptorVersion]
        push rsp
        push r10

        call [rax + EFI_BOOT_SERVICES.GetMemoryMap]

        pop  r10
        pop  rsp

        cmp  rax, EFI_SUCCESS
        jne  bootServiceError

        ret

exitBootServices:
        mov  rax, [systemTable]
        mov  rax, [rax + EFI_SYSTEM_TABLE.BootServices]
 
        mov  rcx, [imageHandle]
        mov  rdx, [mapKey]
 
        call [rax + EFI_BOOT_SERVICES.ExitBootServices]

        cmp  rax, EFI_SUCCESS
        jne  bootServiceError
        
        ret

bootServiceError:
        hlt
        jmp bootServiceError