#include "gpt.h"
#include "types.h"

void delay(int count)
{
	uint32 value;

	/* Setup Delay Count */
	REG_WRITE(GPT_OCR1, count);

	/* Clear Status */
	REG_WRITE(GPT_SR, GPT_OF_ALL_EVENTS);

	/* Disable Timer */
	value = REG_READ(GPT_CR) & ~(GPT_ENABLE);
	REG_WRITE(GPT_CR, value);

	/* Reset Timer */
	REG_WRITE(GPT_CR, GPT_INIT);

	/* Enable Timer */
	value = REG_READ(GPT_CR) | GPT_ENABLE;
	REG_WRITE(GPT_CR, value);

	/* Wait for Overflow */
	do
	{
		value = REG_READ(GPT_SR) & GPT_OF1;
	} while(value == 0);

	/* Disable Timer */
	value = REG_READ(GPT_CR) & ~(GPT_ENABLE);
	REG_WRITE(GPT_CR, value);
}

void clock(int count)
{
	uint32 value;

	/* Setup Delay Count */
	REG_WRITE(GPT_OCR1, count);

	/* Clear Status */
	REG_WRITE(GPT_SR, GPT_OF_ALL_EVENTS);

	/* Disable Timer */
	value = REG_READ(GPT_CR) & ~(GPT_ENABLE);
	REG_WRITE(GPT_CR, value);

	/* Reset Timer */
	REG_WRITE(GPT_CR, GPT_INIT);

	/* Enable Timer */
	value = REG_READ(GPT_CR) | GPT_ENABLE;
	REG_WRITE(GPT_CR, value);
}

int timeout(void)
{
	int value, status = FALSE;

	value = REG_READ(GPT_SR) & GPT_OF1;
	if(value != 0)
	{
		status = TRUE;
	}

	return status;
}

void declock(void)
{
	uint32 value;

	value = REG_READ(GPT_CR) | GPT_ENABLE;
	REG_WRITE(GPT_CR, value);
}
