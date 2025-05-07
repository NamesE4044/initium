# Project
MCU = cortex-m3
CPU = -mcpu=$(MCU)
FPU = -mfloat-abi=soft
OPT = -O0

OUT = flash

# Toolchain
CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy

# Paths
PICOLIB_DIR = /usr/lib/picolibc/arm-none-eabi
PICOLIBC_INC = $(PICOLIB_DIR)/include
PICOLIBC_LIB = $(PICOLIB_DIR)/lib

PROJ_DIR = .
BUILD_DIR = $(PROJ_DIR)/build
INCLUDE_DIR = $(PROJ_DIR)/include
LINKER_DIR = $(PROJ_DIR)/linker

# Source files
LINKER = $(LINKER_DIR)/linker.ld
MAP_FILE = $(BUILD_DIR)/firmware.map

C_SRC = main.c $(wildcard src/*.c)
ASM_SRC = $(wildcard src/*.s)

# Object files
MAIN_OBJ = $(BUILD_DIR)/main.o
C_OBJS = $(patsubst %.c, $(BUILD_DIR)/%.o, $(notdir $(filter-out main.c, $(C_SRC))))
ASM_OBJS = $(patsubst src/%.s, $(BUILD_DIR)/%.o, $(ASM_SRC))

OBJS = $(MAIN_OBJ) $(C_OBJS) $(ASM_OBJS)

# Build flags
CFLAGS = $(CPU) $(FPU) $(OPT) -Wall -ffunction-sections -ffreestanding \
	 -fdata-sections -nostdinc -I$(PICOLIBC_INC) -I$(INCLUDE_DIR)
LDFLAGS = -T $(LINKER) -L$(PICOLIBC_LIB) -nostdlib -Map=$(MAP_FILE)
ASFLAGS = $(CPU) $(FPU)

# Flasher util
FLASHER = st-flash
FLASH_ADDR = 0x08000000

.PHONY: all clean flash erase

# Build rules
all: $(BUILD_DIR)/$(OUT).bin

$(BUILD_DIR):
	mkdir -p $@

# Link object files into ELF
$(BUILD_DIR)/$(OUT).elf: $(OBJS) | $(BUILD_DIR)
	$(LD) $(LDFLAGS) -o $@ $^

# Compile C files from root dir (main.c)
$(BUILD_DIR)/main.o: main.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: src/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Compile assembly files
$(BUILD_DIR)/%.o: src/%.s | $(BUILD_DIR)
	$(AS) $(ASFLAGS) -o $@ $<

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(OBJCOPY) -O binary $< $@
	ls -lh $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

flash:
	$(FLASHER) erase
	$(FLASHER) write $(BUILD_DIR)/$(OUT).bin $(FLASH_ADDR)

erase:
	$(FLASHER) erase
