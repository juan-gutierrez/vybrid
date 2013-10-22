#include "types.h"
#include "iomux_register.h"

#define GPIO5_ADDR_GDIR (GPIO5_BASE_ADDR + 0x04)
#define GPIO5_ADDR_DR   (GPIO5_BASE_ADDR + 0x00)

/* GPIO5-15 as debug LED */
#define GPIO_BIT_DEBUG_LED 15

extern void delay(int);

void main(void)
{
	unsigned int val;
	int LED_on = FALSE;

	/* Configure IOMUX */
	REG_WRITE(IOMUXC_SW_MUX_CTL_PAD_DISP0_DAT21, 5);

	/* Configure GPIO direction */
	val = (REG_READ(GPIO5_ADDR_GDIR)) | (1 << GPIO_BIT_DEBUG_LED);
	REG_WRITE(GPIO5_ADDR_GDIR, val);

	/* Read initial value */
	val = REG_READ(GPIO5_ADDR_DR);

	while(TRUE)
	{
		if(LED_on == TRUE)
		{
			LED_on = FALSE;

			/* Toggle off */
			val &= ~(1 << GPIO_BIT_DEBUG_LED);
			REG_WRITE(GPIO5_ADDR_DR, val);
		}
		else
		{
			LED_on = TRUE;

			/* Toggle on */
			val |= 1 << GPIO_BIT_DEBUG_LED;
			REG_WRITE(GPIO5_ADDR_DR, val);
		}

		/* Delay ONE second */
		delay(32768);
	}
}
