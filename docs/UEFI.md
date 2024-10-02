# General Overview of the UEFI bootloader

## Definitions

All information is platform-independent, as it is directly from the Specifications
found at [UEFI Spec (August-2024)][1]

[1]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_A_Aug8.pdf

### Constants

These are UEFI defined constants, and are primarily used as status codes and pointers

| **Name**                       | **Value**          | **Description**
|:---                            |:---                |:---
| EFI_SUCCESS                    | 0x0000000000000000 | Operation completed succesfully
| EFI_LOAD_ERROR                 | 0x8000000000000001 | Image failed to load
| EFI_INVALID_PARAMETER          | 0x8000000000000002 | A parameter was incorrect
| EFI_UNSUPPORTED                | 0x8000000000000003 | The operation is unsupported
| EFI_BAD_BUFFER_SIZE            | 0x8000000000000004 | The buffer was the wrong size
| EFI_NOT_FOUND                  | 0x8000000000000014 | The item was not found
| EFI_SYSTEM_TABLE_SIGNATURE     | 0x5453595320494249 | System Table Signature
| EFI_BOOT_SERVICES_SIGNATURE    | 0x56524553544f4f42 | Boot Services Signature
| EFI_RUNTIME_SERVICES_SIGNATURE | 0x56524553544e5552 | Runtime Services Signature
| EFI_BLACK                      | 0x00               | Foreground black
| EFI_BLUE                       | 0x01               | Foreground blue
| EFI_GREEN                      | 0x02               | Foreground green
| EFI_CYAN                       | 0x03               | Foreground cyan
| EFI_RED                        | 0x04               | Foreground red
| EFI_MAGENTA                    | 0x05               | Foreground magenta
| EFI_BROWN                      | 0x06               | Foreground brown
| EFI_LIGHTGRAY                  | 0x07               | Foregound light gray
| EFI_BRIGHT                     | 0x08               | Foreground bright gray
| EFI_DARKGRAY                   | 0x08               | Foreground dark gray
| EFI_LIGHTBLUE                  | 0x09               | Foreground light blue
| EFI_LIGHTGREEN                 | 0x0A               | Foreground light green
| EFI_LIGHTCYAN                  | 0x0B               | Foreground light cyan
| EFI_LIGHTRED                   | 0x0C               | Foreground light red
| EFI_LIGHTMAGENTA               | 0X0D               | Foreground light magenta
| EFI_YELLOW                     | 0x0E               | Foreground yellow
| EFI_WHITE                      | 0X0F               | Foreground white
| EFI_BACKGROUND_BLACK           | 0x00               | Background black
| EFI_BACKGROUND_BLUE            | 0x10               | Background blue
| EFI_BACKGROUND_GREEN           | 0x20               | Background green
| EFI_BACKGROUND_CYAN            | 0x30               | Background cyan
| EFI_BACKGROUND_RED             | 0x40               | Background red
| EFI_BACKGROUND_MAGENTA         | 0x50               | Background magenta
| EFI_BACKGROUND_BROWN           | 0x60               | Background brown
| EFI_BACKGROUND_LIGHTGRAY       | 0x70               | Background light gray

### Types

All types are defined as macros that reserve bytes with particular alignment.
The alignment I have guessed to ensure that everything is Right-aligned. No clue
if that is right, but (hopefully) shouldn't matter too much

Not all types have been implemented, in particular abstract pointers. Those are
implemented using the VOIDPOINTER macro

| **Type**    | **Size** | **Alignment** | **Description**
|:---         |:---      |:---           | :---
| UINTN       | 8 bytes  | 8             | Default register size for the OS
| UINT32      | 4 bytes  | 4             | Unsigned 32-bit integer
| UINT64      | 8 bytes  | 8             | Unsigned 64-bit integer
| INT32       | 4 bytes  | 4             | Signed 32-bit integer
| CHAR16      | 2 bytes  | 2             | UTF-16 encoded character
| BOOLEAN     | 1 bytes  | 1             | Boolean (to be used as 0x00 or 0x11)
| VOIDPOINTER | 8 bytes  | 8             | Generic 64-bit Pointer (placeholder type)
| EFI_HANDLE  | 8 bytes  | 8             | Handle to EFI Streams (input, output, error)
| EFI_EVENT   | 8 bytes  | 8             | Boot-time Events (unused)

### Tables

All of these tables must be fully defined to ensure that the memory alignment remains
correct. As such, even though only about 5 functions are really required, all tables
are complete.

| **Name**                          | **Description**
| :---                              | :---
| EFI_TABLE_HEADER                  | Contains metadata for all other tables
| EFI_SYSTEM_TABLE                  | Contains all pointers to all other services
| EFI_BOOT_SERVICES                 | Services that are available at boot time, they go out of scope after kernel is loaded
| EFI_RUNTIME_SERVICES              | Services that remain available after kernel is loaded
| SIMPLE_TEXT_OUTPUT_MODE           | Metadata for text output
| EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL   | Text Output Services
| EFI_MEMORY_DESCRIPTOR             | Memory layout description
| EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE | Basic graphics metadata
| EFI_GRAPHICS_OUTPUT_PROTOCOL      | Basic graphics services
