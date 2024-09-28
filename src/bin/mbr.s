%include "./src/bin/efi_defs.s"

struc MASTER_BOOT_RECORD_PARTITION 
        .bootIndicator          UINT8
        .startingChs            UINT8
                                UINT8
                                UINT8
        .OSType                 UINT8
        .endingChs              UINT8
                                UINT8
                                UINT8
        .startingLBA            UINT32
        .endingLBA              UINT32
endstruc

%macro MBRPARTITION 0
        resb MASTER_BOOT_RECORD_PARTITION
%endmacro

struc MASTER_BOOT_RECORD
        .bootcode               times 440 UINT8
        .MBRSignature           UINT32
        .unknown                UINT16
        .MBRPartition           MBRPARTITION
        .bootSignature          UINT16
endstruc