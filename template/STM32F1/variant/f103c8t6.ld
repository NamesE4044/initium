/*
 * ================================================================================================
 *  Linker Script for STM32F103xB (Medium-Density Devices)
 *  Target Example: STM32F103C8T6
 *
 *  Description:
 *  - Defines memory layout for flash and RAM.
 *  - Specifies placement of program sections (.data, .bss, .text)
 *  - Used by arm-none-eabi-ld to link object files into a flat binary file for flashing
 *
 *  Flash: 64KB at 0x08000000
 *  RAM:   20KB at 0x20000000
 *
 *  Sections:
 *  - .isr_vector:	Interrupt Vector Table
 *  - .text:		Code and constants
 *  - .data/.bss	Initialized and zero-initialized RAM
 *
 *  Version: 1.0.0
 *  Date: 2025-04-23
 *  Copyright 2025 Eric Robyn-Hardy
 *  Licensed under the MIT License - See LICENSE file or https://github.com/NamesE4044/ustart
 * ================================================================================================
 */
/* Entry Point */
ENTRY(Reset_Handler)

MEMORY
{
	FLASH (RX) : ORIGIN = 0x08000000, LENGTH = 64K
	RAM (RWX)  : ORIGIN = 0x20000000, LENGTH = 20K
}

_estack = ORIGIN(RAM) + LENGTH(RAM); /* Stack Pointer */

SECTIONS
{
	.isr_vector :
	{
		KEEP(*(.isr_vector))
		. = ALIGN(64);
	} > FLASH

	.text :
	{
		. = ALIGN(4);
		KEEP(*(.text))
		*(.text*)
		*(.rodata)
	} > FLASH

	_sidata = LOADADDR(.data); /* Address of .data in Flash */

	.data :
	{
		_sdata = .;
		*(.data*)
		. = ALIGN(4);
		_edata = .;
	} > RAM AT > FLASH

	.bss :
	{
		_sbss = .;
		*(.bss)
		*(COMMON)
		_ebss = .;
	} > RAM
}
