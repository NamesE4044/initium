/*
 * ===============================================================================
 *  STM32F103xB Register Definitions
 *  Target Devices: STM32F103C6, C8, CB, R8, RB (Medium-Density)
 *
 *  Description:
 *  - Provides register-level definitions for core peripherals.
 *  - Minimal CMSIS alternative. NO external dependencies 
 *  - Designed for bare-metal projects using the STM32F103xB family
 *
 *
 *  Notes:
 *  - Based on STM32 Reference Manual RM0008 and STM32F103xB datasheet.
 *  - Flash and RAM layout assumed to match STM32 Medium-Density device specs.
 *  - Must match linker script and startup code expectations
 *
 *  Version: 1.0.0
 *  Author: Eric Hardy
 *  Date 2025-04-23
 * ================================================================================
 */

#ifndef STM32F103_H
#define STM32F103_H

#include <stdint.h>

#define RCC_BASE	(0x40021000UL)
#define GPIOC_BASE	(0x40011000UL)

typedef struct {
	volatile uint32_t CR;
	volatile uint32_t CFGR;
	volatile uint32_t CIR;
	volatile uint32_t APB2RSTR;
	volatile uint32_t APB1RSTR;
	volatile uint32_t AHBENR;
	volatile uint32_t APB2ENR;
	volatile uint32_t APB1ENR;
	volatile uint32_t BDCR;
	volatile uint32_t CSR;
} RCC_TypeDef;

typedef struct {
	volatile uint32_t CRL;
	volatile uint32_t CRH;
	volatile uint32_t IDR;
	volatile uint32_t ODR;
	volatile uint32_t BSRR;
	volatile uint32_t BRR;
	volatile uint32_t LCKR;
}GPIO_TypeDef;

#define RCC	((RCC_TypeDef*)RCC_BASE)
#define GPIOC	((GPIO_TypeDef*)GPIOC_BASE)

#endif
