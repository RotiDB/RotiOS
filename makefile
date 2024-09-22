ASM       := nasm
SRC_DIR   := src/asm
BUILD_DIR := target/bin
BINARY	  := main.bin
IMAGE     := main.img
NASMFLAGS := -f bin
PADDING   := 1440k
SRC       := $(notdir $(wildcard $(SRC_DIR)/*))
BUILD     := $(notdir $(wildcard $(BUILD_DIR)/*))

all:
	@mkdir -p $(BUILD_DIR)

	${ASM} ${SRC_DIR}/main.s ${NASM_FLAGS} -o \
	${BUILD_DIR}/${BINARY}

	cp ${BUILD_DIR}/${BINARY} ${BUILD_DIR}/${IMAGE} 

	truncate -s ${PADDING} ${BUILD_DIR}/${IMAGE} 

.PHONY: all clean info

clean:
	rm -rvf $(BUILD_DIR)

info:
	@echo "[*] Source dir:   ${SRC_DIR}        "
	@echo "[*]  Contents:    ${SRC}			   "
	@echo "------------------------------------"
	@echo "[*]  Build dir:   ${BUILD_DIR}      "
	@echo "[*]  Contents:    ${BUILD}          "