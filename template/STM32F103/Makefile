MCU = cortex-m3
CPU = -mcpu=$(MCU)
FPU = -mfloat-abi=soft
OPT = -O0

BUILD_DIR = "./build"

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy

SRC = main.c
ASM = src/startup.s
LINKER = linker/stm32f103c8t6.ld
MAP_FILE = firmware.map
INCLUDE = -I.

CFLAGS = $(CPU) $(FPU) $(OPT) -Wall -ffunction-sections -ffreestanding -fdata-sections $(INCLUDE)
LDFLAGS = -T $(LINKER) -Map=$(MAP_FILE)

FLASHER = st-flash
FLASH = 0x08000000

OUT = flash

.PHONY: all clean flash erase

all: $(OUT).bin

$(OUT).elf: $(SRC:.c=.o) $(ASM:.s=.o)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(CC) $(CFLAGS) -c -o $@ $<


%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
	mkdir $(BUILD_DIR)
	mv *.o *.elf *.map *.bin $(BUILD_DIR)

clean:
	rm -f *.o *.elf *.bin
	rm -rf $(BUILD_DIR)


flash:
	$(FLASHER) erase
	$(FLASHER) write $(OUT).bin $(FLASH)

erase:
	$(FLASHER) erase
