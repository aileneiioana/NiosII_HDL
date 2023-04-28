#include <stdio.h>
#include <system.h>
#include <sys/alt_irq.h>
#include <altera_avalon_timer_regs.h>

// Function Declararions
void init_timer_interrupt( void );
static void timer_isr( void * context, alt_u32 id );

int main( void )
{
	printf("Hello from Nios II!\n");
	printf("This is am interrupt example using an interval timer with interrupts.");

	// Enable the timer
	init_timer_interrupt();

	while(1)
	{ }

	return 0;
}

void init_timer_interrupt( void )
{
	// Register the ISR with HAL
	alt_ic_isr_register(TIMER_IRQ_INTERRUPT_CONTROLLER_ID, TIMER_IRQ, (void *)timer_isr, NULL, 0x0);

	// Start the timer
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_BASE, ALTERA_AVALON_TIMER_CONTROL_CONT_MSK
			                                   | ALTERA_AVALON_TIMER_CONTROL_START_MSK
											   | ALTERA_AVALON_TIMER_CONTROL_ITO_MSK);
}

static void timer_isr( void * context, alt_u32 id )
{
	static int count = 0;

	// Clear the interrupt
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_BASE, 0);

	// Do something
	printf("\nTimer Expired: %d", count++);
}
