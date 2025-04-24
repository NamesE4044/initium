MCU = cortex-m3
CPU = -mcpu=$(MCU)
FPU = -mfloat-abi=soft
OPT = -O0

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy

SRC = main.c
ASM = startup.s
LINKER = stm32f103c8t6.ld
INCLUDE = -I.

CFLAGS = $(CPU) $(FPU) $(OPT) -Wall -ffunction-sections -ffreestanding -fdata-sections $(INCLUDE)
LDFLAGS = -T $(LINKER)

FLASHER = st-flash
FLASH = 0x08000000

OUT = flash

all: $(OUT).bin

$(OUT).elf: $(SRC:.c=.o) $(ASM:.s=.o)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(CC) $(CFLAGS) -c -o $@ $<


%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

clean:
	rm -f *.o *.elf *.bin


flash:
	$(FLASHER) erase
	$(FLASHER) write $(OUT).bin $(FLASH)
