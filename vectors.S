#include "asm_defines.h"
#include "soc_memory_map.h"

    .code 32
    .section ".vectors","ax"

#define IMAGE_ADDR		0x00908000
#define IMAGE_SIZE		4 * 1024
/* #define IMAGE_SIZE (__image_end__) - IMAGE_ADDR */

image_header:
	.ascii "Arik ARD Test - GPIO5_15 TOGGLE"

    .org 0x400

ivt_header:         .long 0x402000D1
app2_code_jump_v:  	.long startup
reserv3:            .long 0x0
dcd2_ptr:           .long 0x0
boot_data2_ptr:     .long boot_data2
self_ptr2:          .long ivt_header
app_code_csf2:      .long 0x0
reserv4:            .long 0x0
boot_data2:         .long IMAGE_ADDR
image_len2:         .long IMAGE_SIZE
plugin2:            .long 0

.global startup

startup:

/* enable AIPS zone */
    ldr r0, =AIPS1_BASE_ADDR
    ldr r1, =0x77777777
    str r1, [r0, #0x00]
    str r1, [r0, #0x04]
    ldr r0, =AIPS2_BASE_ADDR
    str r1, [r0, #0x00]
    str r1, [r0, #0x04]

/* setup stacks in different mode */
    ldr     r0, =top_of_stacks
    msr     cpsr_c, #MODE_FIQ | I_BIT | F_BIT
    sub     sp, r0, #OFFSET_FIQ_STACK
    msr     cpsr_c, #MODE_IRQ | I_BIT | F_BIT
    sub     sp, r0, #OFFSET_IRQ_STACK
    msr     cpsr_c, #MODE_ABT | I_BIT | F_BIT
    sub     sp, r0, #OFFSET_ABT_STACK
    msr     cpsr_c, #MODE_UND | I_BIT | F_BIT
    sub     sp, r0, #OFFSET_UND_STACK
    msr     cpsr_c, #MODE_SVC | I_BIT | F_BIT
    sub     sp, r0, #OFFSET_SVC_STACK

/* init bss */
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
