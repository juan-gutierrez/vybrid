#include "dcd.h"
#include "asm_defines.h"
#include "soc_memory_map.h"

#define IMAGE_ENTRY_ADDR 0x3f000000
#define IMAGE_SIZE 8*1024

#define CPU_2_BE_32(l) \
       ((((l) & 0x000000FF) << 24) | \
	(((l) & 0x0000FF00) << 8)  | \
	(((l) & 0x00FF0000) >> 8)  | \
	(((l) & 0xFF000000) >> 24))

#define MXC_DCD_ITEM(i, addr, val)   \
dcd_node_##i:                        \
        .word CPU_2_BE_32(addr) ;     \
        .word CPU_2_BE_32(val)  ;     \

    .code 32
    .section ".vectors","ax"

	.ascii "Vybrid OCRAM test image"

	.org 0x400

	ivt2_header:            .long 0x402000D1
	app2_code_jump_v:       .long startup
	reserv3:                .long 0x0
	dcd2_ptr:               .long dcd_hdr
	boot_data2_ptr:         .long boot_data2
	self_ptr2:              .long ivt2_header
	app_code_csf2:          .long 0x0
	reserv4:                .long 0x0

	boot_data2:             .long IMAGE_ENTRY_ADDR
	image_len2:             .long IMAGE_SIZE
	plugin2:                .long 0x0

	/* DCD header defined here */
	DCD_HEADER

	.org 0x800
	.global startup

startup:

	/* setup stack */
    ldr     r0, =top_of_stacks
    msr     cpsr_c, #MODE_FIQ | I_BIT | F_BIT /* no interrupts*/
    sub     sp, r0, #OFFSET_FIQ_STACK
    msr     cpsr_c, #MODE_IRQ | I_BIT | F_BIT /* no interrupts */
    sub     sp, r0, #OFFSET_IRQ_STACK
    msr     cpsr_c, #MODE_ABT | I_BIT | F_BIT /* no interrupts */
    sub     sp, r0, #OFFSET_ABT_STACK
    msr     cpsr_c, #MODE_UND | I_BIT | F_BIT
    sub     sp, r0, #OFFSET_UND_STACK
    msr     cpsr_c, #MODE_SVC | I_BIT | F_BIT /* no interrupts */
    sub     sp, r0, #OFFSET_SVC_STACK

    /* init .bss */
    ldr     r1,=__bss_start__
    ldr     r2,=__bss_end__
    mov     r3,#0
1:
    cmp     r1,r2
    stmltia r1!,{r3}
    blt     1b

	/* jump into main */
    ldr     r12, =main
    bx      r12

    .end
