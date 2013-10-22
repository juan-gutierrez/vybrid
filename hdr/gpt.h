#ifndef __GPT_HDR__
#define __GPT_HDR__

#include "soc_memory_map.h"

#define GPT_ENABLE                0x00000001
#define GPT_MODE_RESET_COUNTER    0x00000002
#define GPT_32K_CLOCK_SELECT      0x00000100
#define GPT_OF1                   0x00000001
#define GPT_OF_ALL_EVENTS         0x0000003F
#define GPT_INIT                  GPT_MODE_RESET_COUNTER | GPT_32K_CLOCK_SELECT

/* Registers */
#define GPT_CR   (GPT_BASE_ADDR + 0x00)
#define GPT_PR   (GPT_BASE_ADDR + 0x04)
#define GPT_SR   (GPT_BASE_ADDR + 0x08)
#define GPT_IR   (GPT_BASE_ADDR + 0x0C)
#define GPT_OCR1 (GPT_BASE_ADDR + 0x10)
#define GPT_OCR2 (GPT_BASE_ADDR + 0x14)
#define GPT_OCR3 (GPT_BASE_ADDR + 0x18)
#define GPT_ICR1 (GPT_BASE_ADDR + 0x1C)
#define GPT_ICR2 (GPT_BASE_ADDR + 0x20)
#define GPT_CNT  (GPT_BASE_ADDR + 0x24)

#endif
