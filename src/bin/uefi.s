bits 64

%include "./src/bin/efi_defs.s"
%include "./src/bin/efi_boot_services.s"
%include "./src/bin/efi_text_output_services.s"

section .text
global  start

start:
    mov [ptrUEFI], rsp

    sub rsp, 4 * 8
    mov [imageHandle], rcx

    mov [systemTable], rdx
    
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
    call clearScreen
    lea  rcx, string 
    call outputString
    
    call exitKernel

EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID:        dd 0x9042a9de
                                          dd 0x23dc4a38
                                          dd 0x96fb7ade
                                          dd 0xd080516a

section .data
        string                            db   __utf16__ 'Hello World', 13, 10, 13, 10
        exitString                        db   __utf16__ 'Press any key to shutdown...'
        ptrUEFI                           dq   0
        imageHandle                       dq   0
        systemTable                       dq   0
        ptrInterface                      dq   0

        memoryMapSize                     dq   EFI_MEMORY_DESCRIPTOR_size * 1024 ; reserving 1kb of memory at this time
        memoryMap                         resb EFI_MEMORY_DESCRIPTOR_size * 1024
        mapKey                            dq   0
        descriptorSize                    dq   0
        descriptorVersion                 dd   0

        frameBuffer              dq 0
datasize equ $ - $$

