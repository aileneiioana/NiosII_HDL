/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2_0' in SOPC Builder design 'nios_custom_dma'
 * SOPC Builder design path: c:/Users/ailen/Desktop/licenta/Nios_custom_dma/nios_custom_dma.sopcinfo
 *
 * Generated: Wed May 10 15:04:07 EEST 2023
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00042820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x13
#define ALT_CPU_DCACHE_BYPASS_MASK 0x80000000
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x00020020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_EXTRA_EXCEPTION_INFO
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x13
#define ALT_CPU_NAME "nios2_gen2_0"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00020000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00042820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x13
#define NIOS2_DCACHE_BYPASS_MASK 0x80000000
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x00020020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_EXTRA_EXCEPTION_INFO
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x13
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00020000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_NIOS2_GEN2
#define __BLOCK_TRANSACTION_EXAMPLE
#define __BURST_EXAMPLE
#define __PIPELINED_READ_EXAMPLE
#define __SIMPLE_EXAMPLE


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "MAX 10"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x43040
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x43040
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x43040
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "nios_custom_dma"
#define ALT_SYS_CLK_TICKS_PER_SEC NONE_TICKS_PER_SEC
#define ALT_TIMESTAMP_CLK_TIMER_DEVICE_TYPE NONE_TIMER_DEVICE_TYPE


/*
 * block_dma configuration
 *
 */

#define ALT_MODULE_CLASS_block_dma block_transaction_example
#define BLOCK_DMA_BASE 0x43000
#define BLOCK_DMA_IRQ -1
#define BLOCK_DMA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BLOCK_DMA_NAME "/dev/block_dma"
#define BLOCK_DMA_SPAN 16
#define BLOCK_DMA_TYPE "block_transaction_example"


/*
 * burst_dma configuration
 *
 */

#define ALT_MODULE_CLASS_burst_dma burst_example
#define BURST_DMA_BASE 0x43010
#define BURST_DMA_IRQ -1
#define BURST_DMA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BURST_DMA_NAME "/dev/burst_dma"
#define BURST_DMA_SPAN 16
#define BURST_DMA_TYPE "burst_example"


/*
 * dst_ram configuration
 *
 */

#define ALT_MODULE_CLASS_dst_ram altera_avalon_onchip_memory2
#define DST_RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define DST_RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define DST_RAM_BASE 0x41000
#define DST_RAM_CONTENTS_INFO ""
#define DST_RAM_DUAL_PORT 0
#define DST_RAM_GUI_RAM_BLOCK_TYPE "AUTO"
#define DST_RAM_INIT_CONTENTS_FILE "nios_custom_dma_dst_ram"
#define DST_RAM_INIT_MEM_CONTENT 1
#define DST_RAM_INSTANCE_ID "NONE"
#define DST_RAM_IRQ -1
#define DST_RAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DST_RAM_NAME "/dev/dst_ram"
#define DST_RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define DST_RAM_RAM_BLOCK_TYPE "AUTO"
#define DST_RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define DST_RAM_SINGLE_CLOCK_OP 0
#define DST_RAM_SIZE_MULTIPLE 1
#define DST_RAM_SIZE_VALUE 4096
#define DST_RAM_SPAN 4096
#define DST_RAM_TYPE "altera_avalon_onchip_memory2"
#define DST_RAM_WRITABLE 1


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x43040
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * pipelined_dma configuration
 *
 */

#define ALT_MODULE_CLASS_pipelined_dma pipelined_read_example
#define PIPELINED_DMA_BASE 0x43020
#define PIPELINED_DMA_IRQ -1
#define PIPELINED_DMA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIPELINED_DMA_NAME "/dev/pipelined_dma"
#define PIPELINED_DMA_SPAN 16
#define PIPELINED_DMA_TYPE "pipelined_read_example"


/*
 * program configuration
 *
 */

#define ALT_MODULE_CLASS_program altera_avalon_onchip_memory2
#define PROGRAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define PROGRAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define PROGRAM_BASE 0x20000
#define PROGRAM_CONTENTS_INFO ""
#define PROGRAM_DUAL_PORT 0
#define PROGRAM_GUI_RAM_BLOCK_TYPE "AUTO"
#define PROGRAM_INIT_CONTENTS_FILE "nios_custom_dma_program"
#define PROGRAM_INIT_MEM_CONTENT 1
#define PROGRAM_INSTANCE_ID "NONE"
#define PROGRAM_IRQ -1
#define PROGRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PROGRAM_NAME "/dev/program"
#define PROGRAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define PROGRAM_RAM_BLOCK_TYPE "AUTO"
#define PROGRAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define PROGRAM_SINGLE_CLOCK_OP 0
#define PROGRAM_SIZE_MULTIPLE 1
#define PROGRAM_SIZE_VALUE 81920
#define PROGRAM_SPAN 81920
#define PROGRAM_TYPE "altera_avalon_onchip_memory2"
#define PROGRAM_WRITABLE 1


/*
 * simple_dma configuration
 *
 */

#define ALT_MODULE_CLASS_simple_dma simple_example
#define SIMPLE_DMA_BASE 0x43030
#define SIMPLE_DMA_IRQ -1
#define SIMPLE_DMA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SIMPLE_DMA_NAME "/dev/simple_dma"
#define SIMPLE_DMA_SPAN 16
#define SIMPLE_DMA_TYPE "simple_example"


/*
 * src_ram configuration
 *
 */

#define ALT_MODULE_CLASS_src_ram altera_avalon_onchip_memory2
#define SRC_RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define SRC_RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define SRC_RAM_BASE 0x40000
#define SRC_RAM_CONTENTS_INFO ""
#define SRC_RAM_DUAL_PORT 0
#define SRC_RAM_GUI_RAM_BLOCK_TYPE "AUTO"
#define SRC_RAM_INIT_CONTENTS_FILE "nios_custom_dma_src_ram"
#define SRC_RAM_INIT_MEM_CONTENT 1
#define SRC_RAM_INSTANCE_ID "NONE"
#define SRC_RAM_IRQ -1
#define SRC_RAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SRC_RAM_NAME "/dev/src_ram"
#define SRC_RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define SRC_RAM_RAM_BLOCK_TYPE "AUTO"
#define SRC_RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define SRC_RAM_SINGLE_CLOCK_OP 0
#define SRC_RAM_SIZE_MULTIPLE 1
#define SRC_RAM_SIZE_VALUE 4096
#define SRC_RAM_SPAN 4096
#define SRC_RAM_TYPE "altera_avalon_onchip_memory2"
#define SRC_RAM_WRITABLE 1

#endif /* __SYSTEM_H_ */
