#ifndef __TYPES_HDR__
#define __TYPES_HDR__

typedef unsigned char  uint8;
typedef signed char    sint8;

typedef unsigned short uint16;
typedef signed short   sint16;

typedef unsigned int   uint32;
typedef signed int     sint32;

#define NULL (0)

#define TRUE  1
#define FALSE 0

#define SUCCESS 0
#define FAIL    1

#define REG_WRITE(addr, value) *(volatile unsigned int *)(addr) = value
#define REG_READ(addr) (*(volatile unsigned int *)(addr))

#endif
