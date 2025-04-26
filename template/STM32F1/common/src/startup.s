/*
 * =================================================================================================
 *  Startup Code for STM32F103xB (Medium-Density Devices)
 *  Target Example: STM32F103C8T6
 *
 *  Description:
 *  - Defines the vector table, initial stack pointer, and reset handler
 *  - Copies .data section from FLASH to RAM
 *  - Fill .bss section with zero
 *  - Reset_Handler is the entry point after reset and sets up mempry sections
 *
 *  Notes
 *  - This is a minimal implementation for bare-metal development purposes
 *  - No CMSIS dependencies 
 *  - Compatible with arm-none-eabi-gcc toolchains.
 *
 *  Version: 1.0.0
 *  Date: 2025-04-23
 *  Copyright 2025 NamesE4044
 *  Licensed under the MIT License - See LICENSE file or https://github.com/NamesE4044/ustart
 * ==================================================================================================
 */

.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

.global _vector_table
.global Reset_Handler
.global Default_Handler

.section .isr_vector, "a", %progbits
.type _vector_table, %object
.size _vector_table, .-_vector_table

_vector_table:
	.word _estack
	.word Reset_Handler
	.word Default_Handler		/* NMI */
	.word Default_Handler		/* HardFault */
	.word Default_Handler		/* MemManage */
	.word Default_Handler		/* BusFault */
	.word Default_Handler		/* UsageFault */
	.word 0				/* Reserved */
	.word 0				/* Reserved */
	.word 0				/* Reserved */
	.word Default_Handler		/* SVCall */
	.word Default_Handler		/* DebugMonitor */
	.word 0				/* Reserved */
	.word Default_Handler		/* PendSV */
	.word Default_Handler		/* SysTick */

Default_Handler:
	b Default_Handler

.section .text.Reset_Handler
.type Reset_Handler, %function

Reset_Handler:
/* Copy .data section from FLASH to RAM */
	ldr r0, =_sdata /* Start of .data section in RAM */
	ldr r1, =_edata /* End of .data section in RAM */
	ldr r2, =_sidata /* Start of .data section in FLASH */
LoopCopyData:
	cmp r0, r1
	bcs LoopFillBSS  /* If .data is done copying, branch to LoopFillBSS */
	ldr r3, [r2], #4 /* Load Word From Flash */
	str r3, [r0], #4 /* Store Word in RAM */
	b LoopCopyData

LoopFillBSS:
	ldr r0, =_sbss /* Start of .bss */
	ldr r1, =_ebss /* End of .bss */
	movs r2, #0    /* 0 value */
LoopBSS:
	cmp r0, r1
	bcs CallMain
	str r2, [r0], #4
	b LoopBSS

CallMain:
	bl main
	b .
