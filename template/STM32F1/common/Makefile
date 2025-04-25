MCU = cortex-m3
CPU = -mcpu=$(MCU)
FPU = -mfloat-abi=soft
OPT = -O0

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy

BUILD_DIR = build
SRC_DIR = .
SRC = main.c
ASM = src/startup.s
LINKER = linker/linker.ld
MAP_FILE = $(BUILD_DIR)/firmware.map
INCLUDE = -Iinclude
OBJS = $(BUILD_DIR)/main.o $(BUILD_DIR)/startup.o

CFLAGS = $(CPU) $(FPU) $(OPT) -Wall -ffunction-sections -ffreestanding -fdata-sections $(INCLUDE)
LDFLAGS = -T $(LINKER) -Map=$(MAP_FILE)

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
