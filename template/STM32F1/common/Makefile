MCU = cortex-m3
CPU = -mcpu=$(MCU)
FPU = -mfloat-abi=soft
OPT = -O0

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy

PICOLIB_DIR = /usr/lib/picolibc/arm-none-eabi
PICOLIBC_INC = $(PICOLIB_DIR)/include
PICOLIBC_LIB = $(PICOLIB_DIR)/lib
BUILD_DIR = build
SRC_DIR = .
SRC = main.c
SRC += src/*.c
ASM = src/startup.s
LINKER = linker/linker.ld
MAP_FILE = $(BUILD_DIR)/firmware.map
INCLUDE = -Iinclude
OBJS = $(BUILD_DIR)/startup.o $(BUILD_DIR)/main.o

CFLAGS = $(CPU) $(FPU) $(OPT) -Wall -ffunction-sections -ffreestanding -fdata-sections -nostdinc -I$(PICOLIBC_INC) $(INCLUDE)
LDFLAGS = -T $(LINKER) -L$(PICOLIBC_LIB) -nostdlib -Map=$(MAP_FILE)

FLASHER = st-flash
FLASH = 0x08000000

OUT = flash

.PHONY: all clean flash erase

all: $(BUILD_DIR)/$(OUT).bin

$(BUILD_DIR)/$(OUT).elf: $(OBJS)
	mkdir -p $(BUILD_DIR)
	$(LD) $(LDFLAGS) -o $@ $^

$(BUILD_DIR)/%.o: %.c
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: src/%.s
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<


$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf
	$(OBJCOPY) -O binary $< $@

clean:
	rm -rf $(BUILD_DIR)


flash:
	$(FLASHER) erase
	$(FLASHER) write $(BUILD_DIR)/$(OUT).bin $(FLASH)

erase:
	$(FLASHER) erase
