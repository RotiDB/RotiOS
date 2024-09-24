%include "./src/bin/efi_defs.s"
%include "./src/bin/efi_boot_services.s"

bits 64

section .data
        string                      db 'Hello World'
        ptrUEFI                     dq 0
        imageHandle                 dq 0
        ptrSystemTable              dq 0
        ptrInterface                dq 0

        intMemoryMapSize            db EFI_MEMORY_DESCRIPTOR_size * 1024
        bufMemoryMap                db EFI_MEMORY_DESCRIPTOR_size * 1024
        ptrMemoryMapKey             dq 0
        ptrMemoryMapDescSize        dq 0
        ptrMemoryMapDescVersion     dq 0

        ptrFrameBuffer              dq 0
datasize equ $ - $$
