%include "./src/bin/efi_defs.s"
%include "./src/bin/efi_boot_services.s"

bits 64

section .text
global  start

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

getFrameBuffer:
    call locateProtocol
    
    mov  rcx, [ptrInterface]
    mov  rcx, [rcx + EFI_GRAPHICS_OUTPUT_PROTOCOL.Mode]
    mov  rcx, [rcx + EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE.FrameBufferBase]
 
    mov  [ptrFrameBuffer], rcx
    
    ret

exitBootSequence:
    call getMemoryMap
    call exitBootServices
    ret

loadKernel:  
    mov  rcx, [ptrSystemTable]
    and  rdx, 0
 
    mov  r8, 2048 * 100
    call kernelActions 
    ret

kernelActions:
    mov  rcx, [rcx + EFI_SYSTEM_TABLE.ConOut]
    EFI_TEXT_ATTR rbx, EFI_BACKGROUND_BLACK, EFI_GREEN
    mov  rcx, [rcx + EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.SetAttribute]

    call rcx
    ret


section .data
        string                            db   __utf16__ 'Hello World', 13, 10, 13, 10
        exitString                        db   __utf16__ 'Press any key to shutdown...'
        ptrUEFI                           dq   0
        imageHandle                       dq   0
        ptrSystemTable                    dq   0
        ptrInterface                      dq   0

        intMemoryMapSize                  dq   EFI_MEMORY_DESCRIPTOR_size * 1024
        bufMemoryMap                      resb EFI_MEMORY_DESCRIPTOR_size * 1024
        ptrMemoryMapKey                   dq   0
        ptrMemoryMapDescSize              dq   0

        EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID dd 0x9042a9de
                                          dd 0x23dc4a38
                                          dd 0x96fb7ade
                                          dd 0xd080516a

        ptrFrameBuffer              dq 0
datasize equ $ - $$

