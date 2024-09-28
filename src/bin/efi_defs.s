EFI_SUCCESS             EQU 0x0

%macro EFI_ERROR 2
    mov %1, 0x800000000000000
    and %1, %2
%endmacro

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

%macro EFI_EVENT 0
        resq 0x1
        alignb 8
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
        .UnloadImage:                           VOIDPOINTER
        .InstallConfigurationTable:             VOIDPOINTER
        .GetNextMonotonicCount:                 VOIDPOINTER
        .LoadImage:                             VOIDPOINTER
        .SetWatchdogTimer:                      VOIDPOINTER
        .StartImage:                            VOIDPOINTER
        .DisconnectController:                  VOIDPOINTER
        .Exit:                                  VOIDPOINTER
        .CloseProtocol:                         VOIDPOINTER
        .ExitBootServices:                      VOIDPOINTER
        .ProtocolsPerHandle:                    VOIDPOINTER
        .Stall:                                 VOIDPOINTER
        .LocateProtocol:                        VOIDPOINTER
        .ConnectController:                     VOIDPOINTER
        .UninstallMultipleProtocolInterfaces:   VOIDPOINTER
        .OpenProtocol:                          VOIDPOINTER
        .CopyMem:                               VOIDPOINTER
        .OpenProtocolInformation:               VOIDPOINTER
        .CreateEventEx:                         VOIDPOINTER
        .LocateHandleBuffer:                    VOIDPOINTER
        .InstallMultipleProtocolInterfaces:     VOIDPOINTER
        .CalculateCrc32:                        VOIDPOINTER
        .SetMem:                                VOIDPOINTER
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
        .Attribute:                             INT32
        .CursorColumn:                          INT32
        .CursorRow:                             INT32
        .CursorVisible:                         BOOLEAN
endstruc

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
        .Mode:                                  VOIDPOINTER
endstruc

struc EFI_MEMORY_DESCRIPTOR 
        .Type:                                  UINT32
        .PhysicalStart:                         VOIDPOINTER
        .VirtualStart:                          VOIDPOINTER
        .NumberOfPages:                         UINT64
        .Attribute:                             UINT64
endstruc

struc EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE
        .MaxMode:                               UINT32
        .Mode:                                  UINT32
        .Info:                                  VOIDPOINTER
        .SizeOfInfo:                            UINTN
        .FrameBufferBase:                       UINT64
        .FrameBufferSize:                       UINTN
endstruc

struc EFI_GRAPHICS_OUTPUT_PROTOCOL 
        .QueryMode:                             VOIDPOINTER
        .SetMode:                               VOIDPOINTER
        .Blt:                                   VOIDPOINTER
        .Mode:                                  VOIDPOINTER
endstruc