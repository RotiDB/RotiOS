struc MBR_PARTITION_RECORD
        .BootIndicator:         UINT8
        .StartHead:             UINT8
        .StartSector:           UINT8
        .StartTrack:            UINT8
        .OSIndicator:           UINT8
        .EndHead:               UINT8
        .EndSector:             UINT8
        .EndTrack:              UINT8
        .StartingLBA:           UINT32
        .SizeInLBA:             UINT32
endstruc

struc MASTER_BOOT_RECORD
        .BootStrapCode:         resb 440 * 8 
        .UniqueMbrSignature:    UINT32
        .Unknown:               UINT16
        .Partition:             resb MBR_PARTITION_RECORD_size * 4
        .Signature:             UINT16
endstruc