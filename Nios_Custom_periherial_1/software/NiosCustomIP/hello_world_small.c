#include <stdio.h>
#include <system.h>
#include <io.h>

int main (void){

	printf("Welcome to the Custom Peripheral");

	IOWR(LEDS_BASE, 0, 0x155);

	printf("Custom Peripheral: 0x%x\n", IORD(LEDS_BASE, 0));

	while(1){

	}

	return 0;
}
