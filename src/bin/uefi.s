%include "./src/bin/efi_defs.s"
%include "./src/bin/efi_boot_services.s"

bits 64

section .text
global start

start:
    mov [ptrUEFI], rsp

    sub rsp, 4 * 8
    mov [imageHandle], rbx

    mov [ptrSystemTable], rax
    
    ; In theory, this should be all we have to do
    ; Should probably include a verification step
    ; So we don't accidentally blow up the emulator

    call getFrameBuffer
    call exitBootSequence
    call loadKernel

; Functions not implemented yet
getFrameBuffer:
    call locateProtocol
    ; write some stuff to get the base address of frame buffer
    ; call outputString
    ret

exitBootSequence:
    call getMemoryMap
    call exitBootServices
    ret

loadKernel:  
    ; Write an actual kernel
    ret

section .data
        string                      db   __utf16__ 'Hello World'
        ptrUEFI                     dq   0
        imageHandle                 dq   0
        ptrSystemTable              dq   0
        ptrInterface                dq   0

        intMemoryMapSize            dq   EFI_MEMORY_DESCRIPTOR_size * 1024
        bufMemoryMap                resb EFI_MEMORY_DESCRIPTOR_size * 1024
        ptrMemoryMapKey             dq   0
        ptrMemoryMapDescSize        dq   0

        EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID dd 0x9042a9de
                                          dd 0x23dc4a38
                                          dd 0x96fb7ade
                                          dd 0xd080516a

        ptrFrameBuffer              dq 0
datasize equ $ - $$

