ASM       := nasm
SRC_DIR   := src/bin
BUILD_DIR := target/bin
NASMFLAGS := -f bin
PADDING   := 256k
SRC       := $(notdir $(wildcard $(SRC_DIR)/*))
BUILD     := $(notdir $(wildcard $(BUILD_DIR)/*))

all:
	@echo "Build for BIOS using 'make bios' or UEFI using 'make uefi'"

.PHONY: all clean info bios uefi

uefi: $(wildcard $(SRC_DIR)/*)
	@mkdir -p $(BUILD_DIR)

	$(ASM) $(SRC_DIR)/uefi.s ${NASMFLAGS} -o \
	${BUILD_DIR}/uefi.bin

	cp ${BUILD_DIR}/uefi.bin ${BUILD_DIR}/uefi.img

	truncate -s ${PADDING} ${BUILD_DIR}/uefi.img
	
bios:
	@mkdir -p $(BUILD_DIR)

	${ASM} ${SRC_DIR}/bios.s ${NASMFLAGS} -o \
	${BUILD_DIR}/bios.bin

	cp ${BUILD_DIR}/bios.bin ${BUILD_DIR}/bios.img 

	truncate -s ${PADDING} ${BUILD_DIR}/bios.img

clean:
	rm -rvf $(BUILD_DIR)

info:
	@echo "[*] Source dir:   ${SRC_DIR}/        "
	@echo "[*] Contents:     ${SRC}			   "
	@echo "------------------------------------"
	@echo "[*] Build dir:    ${BUILD_DIR}/      "
	@echo "[*] Contents:     ${BUILD}          "