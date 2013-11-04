# GCC tool chain
CC= arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
OBJDUMP = arm-none-eabi-objdump

#defines
C_DEFINES =
C_INCLUDES = -Ihdr

BUILD_OBJ = vybrid_test
TARGET_ELF = $(BUILD_OBJ).elf
TARGET_BIN = $(BUILD_OBJ).img
TARGET_MAP = $(BUILD_OBJ).map
TARGET_ASM = $(BUILD_OBJ).asm

# flags
L_FLAGS = -T linker_script
C_FLAGS = -mcpu=cortex-a5 -Wall -Wpointer-arith -Wstrict-prototypes -Winline -Wundef  -mapcs -ffunction-sections -fdata-sections -fno-exceptions -O0

.PHONY: target clean

target:
	$(CC) -o $(TARGET_ELF) src/*.* $(C_FLAGS) $(C_INCLUDES) $(C_DEFINES) -Wl,--no-whole-archive $(L_FLAGS)
	$(OBJCOPY) -O binary $(TARGET_ELF) $(TARGET_BIN)
	$(OBJDUMP) -h $(TARGET_ELF) > $(TARGET_MAP)
	$(OBJDUMP) -S $(TARGET_ELF) > $(TARGET_ASM)
#	mv $(TARGET_BIN) /home/b30266/

clean:
	rm -f *.o
	rm -f $(BUILD_OBJ).*
#	rm -f /home/b30266/$(TARGET_BIN)
