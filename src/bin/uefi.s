EFI_SUCCESS             EQU 0x0
EFI_LOAD_ERROR          EQU 0x8000000000000001
EFI_INVALID_PARAMTER    EQU 0x8000000000000002
EFI_UNSUPPORTED         EQU 0x8000000000000003
EFI_BAD_BUFFER_SIZE     EQU 0x8000000000000004
EFI_NOT_FOUND           EQU 0x8000000000000014

%macro UINTN 0
        resq 0x1
        alignb 0x8
%endmacro

%macro UINT32 0
        resd 0x1
        alignb 0x4
%endmacro

%macro UINT64 0
        resq 0x1
        alignb 0x8
%endmacro

%macro INT32 0
        resd 0x1
        alignb 0x4
%endmacro

%macro CHAR16 0
        resw 0x1
        alignb 0x2
%endmacro

%macro BOOLEAN 0
        resb 0x1
%endmacro

%macro VOIDPOINTER 0
        resq 0x1
        alignb 0x8
%endmacro

%macro EFI_HANDLE 0
        resq 0x1
        alignb 0x8
%endmacro

struc EFI_TABLE_HEADER
        .Signature:                             UINT64
        .Revison:                               UINT32
        .HeaderSize:                            UINT32
        .CRC32:                                 UINT32
        .Reserved:                              UINT32
endstruc

%macro HDRSIZE 0
        resb EFI_TABLE_HEADER_size
%endmacro

%define EFI_SYSTEM_TABLE_SIGNATURE 0x5453595320494249
struc EFI_SYSTEM_TABLE
        .Hdr:                                   HDRSIZE
        .FirmwareVendor:                        CHAR16
        .FirmwareRevision:                      UINT32
        .ConsoleInHandle:                       EFI_HANDLE
        .ConIn:                                 VOIDPOINTER
        .ConsoleOutHandle:                      EFI_HANDLE
        .ConOut:                                VOIDPOINTER
        .StandardErrorHandle:                   EFI_HANDLE
        .StdErr:                                VOIDPOINTER
        .RuntimeServices:                       VOIDPOINTER
        .BootServices:                          VOIDPOINTER
        .NumberOfTableEntries:                  UINTN
        .ConfigurationTable:                    VOIDPOINTER
endstruc

%define EFI_BOOT_SERVICES_SIGNATURE 0x56524553544f4f42
struc EFI_BOOT_SERVICES
        .Hdr:                                   HDRSIZE
        .RaiseTPL:                              VOIDPOINTER
        .RestoreTPL:                            VOIDPOINTER
        .AllocatePages:                         VOIDPOINTER
        .FreePages:                             VOIDPOINTER
        .GetMemoryMap:                          VOIDPOINTER
        .AllocatePool:                          VOIDPOINTER
        .FreePool:                              VOIDPOINTER
        .CreateEvent:                           VOIDPOINTER
        .SetTimer:                              VOIDPOINTER
        .WaitForEvent:                          VOIDPOINTER
        .SignalEvent:                           VOIDPOINTER
        .CloseEvent:                            VOIDPOINTER
        .CheckEvent:                            VOIDPOINTER
        .InstallProtocolInterface:              VOIDPOINTER
        .ReinstallProtocolInterface:            VOIDPOINTER
        .UninstallProtocolInterface:            VOIDPOINTER
        .HandleProtocol:                        VOIDPOINTER
        .Reserved:                              VOIDPOINTER
        .RegisterProtocolNotify:                VOIDPOINTER
        .LocateHandle:                          VOIDPOINTER
        .LocateDevicePath:                      VOIDPOINTER
        .InstallConfigurationTable:             VOIDPOINTER
        .LoadImage:                             VOIDPOINTER
        .StartImage:                            VOIDPOINTER
        .Exit:                                  VOIDPOINTER
        .UnloadImage:                           VOIDPOINTER
        .ExitBootServices:                      VOIDPOINTER
        .GetNextMonotonicCount:                 VOIDPOINTER
        .Stall:                                 VOIDPOINTER
        .SetWatchdogTimer:                      VOIDPOINTER
        .ConnectController:                     VOIDPOINTER
        .DisconnectController:                  VOIDPOINTER
        .OpenProtocol:                          VOIDPOINTER
        .CloseProtocol:                         VOIDPOINTER
        .OpenProtocolInformation:               VOIDPOINTER
        .ProtocolsPerHandle:                    VOIDPOINTER
        .LocateHandleBuffer:                    VOIDPOINTER
        .LocateProtocol:                        VOIDPOINTER
        .InstallMultipleProtocolInterfaces:     VOIDPOINTER
        .UninstallMultipleProtocolInterfaces:   VOIDPOINTER
        .CalculateCrc32:                        VOIDPOINTER
        .CopyMem:                               VOIDPOINTER
        .SetMem:                                VOIDPOINTER
        .CreateEventEx:                         VOIDPOINTER
endstruc

%define EFI_RUNTIME_SERVICES_SIGNATURE 0x56524553544e5552
struc EFI_RUNTIME_SERVICES
        .Hdr:                                   HDRSIZE
        .GetTime:                               VOIDPOINTER
        .SetTime:                               VOIDPOINTER
        .GetWakeupTime:                         VOIDPOINTER
        .SetWakeupTime:                         VOIDPOINTER
        .SetVirtualAddressMap:                  VOIDPOINTER
        .ConvertPointer:                        VOIDPOINTER
        .GetVariable:                           VOIDPOINTER
        .GetNextVariableName:                   VOIDPOINTER
        .GetNextHighMonotonicCount:             VOIDPOINTER
        .ResetSystem:                           VOIDPOINTER
        .UpdateCapsule:                         VOIDPOINTER
        .QueryCapsuleCapabilities:              VOIDPOINTER
        .QueryVariableInfo:                     VOIDPOINTER
endstruc

struc SIMPLE_TEXT_OUTPUT_MODE
        .MaxMode:                               INT32                               
        .Mode:                                  INT32
        .Attirbute:                             INT32
        .CursorColumn:                          INT32
        .CursorRow:                             INT32
        .CursorVisible:                         BOOLEAN
endstruc

%macro TEXTOUTPUTMODE 0
        resb SIMPLE_TEXT_OUTPUT_MODE_size
%endmacro

struc EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
        .Reset:                                 VOIDPOINTER
        .OutputString:                          VOIDPOINTER
        .TestString:                            VOIDPOINTER
        .QueryMode:                             VOIDPOINTER
        .SetMode:                               VOIDPOINTER
        .SetAttribute:                          VOIDPOINTER
        .ClearScreen:                           VOIDPOINTER
        .EnableCursor:                          VOIDPOINTER
        .SetCursorPosition:                     VOIDPOINTER
        .Mode:                                  TEXTOUTPUTMODE
endstruc

bits 64

OutputString:
        mov rdx, rcx

        mov rcx, [EFI_SYSTEM_TABLE]
        mov rcx, [rcx + EFI_SYSTEM_TABLE.ConOut]

