
%macro EFI_ERROR 2
        mov %1, 0x800000000000000
        and %1, %2
%endmacro

%macro UINTN 0
        resq 0x1
        alignb 0x8
%endmacro

%macro UINT16 0
        resw 0x1
        alignb 0x2
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
        resd   0x1
        alignb 0x4
%endmacro

%macro CHAR16 0
        resw   0x1
        alignb 0x2
%endmacro

%macro BOOLEAN 0
        resb   0x1
%endmacro

%macro VOIDPOINTER 0
        resq   0x1
        alignb 0x8
%endmacro

%macro EFI_HANDLE 0
        resq   0x1
        alignb 0x8
%endmacro

%macro EFI_EVENT 0
        resq 0x1
        alignb 8
%endmacro

%macro pCHAR16 0
        resq   0x1
        alignb 0x8
%endmacro 

; EFI Status Codes
EFI_SUCCESS EQU 0x0

; EFI colour definitions
EFI_BLACK                EQU 0x00
EFI_BLUE                 EQU 0x01
EFI_GREEN                EQU 0x02
EFI_CYAN                 EQU 0x03
EFI_RED                  EQU 0x04
EFI_MAGENTA              EQU 0x05
EFI_BROWN                EQU 0x06
EFI_LIGHTGRAY            EQU 0x07
EFI_BRIGHT               EQU 0x08
EFI_DARKGRAY             EQU 0x08
EFI_LIGHTBLUE            EQU 0x09
EFI_LIGHTGREEN           EQU 0x0A
EFI_LIGHTCYAN            EQU 0x0B
EFI_LIGHTRED             EQU 0x0C
EFI_LIGHTMAGENTA         EQU 0X0d
EFI_YELLOW               EQU 0x0E
EFI_WHITE                EQU 0X0F
EFI_BACKGROUND_BLACK     EQU 0x00
EFI_BACKGROUND_BLUE      EQU 0x10
EFI_BACKGROUND_GREEN     EQU 0x20
EFI_BACKGROUND_CYAN      EQU 0x30
EFI_BACKGROUND_RED       EQU 0x40
EFI_BACKGROUND_MAGENTA   EQU 0x50
EFI_BACKGROUND_BROWN     EQU 0x60
EFI_BACKGROUND_LIGHTGRAY EQU 0x70

%macro EFI_TEXT_ATTR 3
        mov %1, %2
        shl %1, 4
        or  %1, %3
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
        .FirmwareVendor:                        pCHAR16
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
