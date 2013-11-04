#ifndef __DCD_HDR__
#define __DCD_HDR__

#include "soc_memory_map.h"

#define CPU_2_BE_32(l) \
       ((((l) & 0x000000FF) << 24) | \
	(((l) & 0x0000FF00) << 8)  | \
	(((l) & 0x00FF0000) >> 8)  | \
	(((l) & 0xFF000000) >> 24))

#define MXC_DCD_ITEM(i, addr, val)   \
dcd_node_##i:                        \
        .word CPU_2_BE_32(addr) ;     \
        .word CPU_2_BE_32(val)  ;     \


.macro DCD_HEADER

dcd_hdr:          .word 0x400800D2 /* Tag=0xD2, Len=0x08, Ver=0x40 */
write_dcd_cmd:    .word 0x040400CC /* Tag=0xCC, Len=0x04, Param=0x04 */

.endm

#endif
