/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */
/*
#include <stdio.h>

int main()
{
  printf("Hello from Nios II!\n");

  return 0;
}
*/
#include <system.h>
#include <altera_avalon_pio_regs.h>
#include <alt_types.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/alt_irq.h>
#include <io.h>

alt_u16 SWITCHES_value;


int main()
{
  while(1)
  {
SWITCHES_value = IORD_ALTERA_AVALON_PIO_DATA(SWITCHES_BASE);
   if((SWITCHES_value) == 0x00)
   {
   // printf("LED OFF!\n");
    IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE,0x00); // set led pin low
    usleep(500);
   }
   else if((SWITCHES_value) != 0x00)
   {
    //printf("LED ON!\n");
    IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE,SWITCHES_value); // set led pin high
    usleep(500);
   }
  }
  return 0;
}

