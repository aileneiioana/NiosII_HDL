#include "altera_up_avalon_accelerometer_spi.h"
#include "system.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdint.h>

int main(void){

	alt_up_accelerometer_spi_dev * acc_dev;

	acc_dev = alt_up_accelerometer_spi_open_dev ("/dev/accelerometer_spi_0");

	//
	if ( acc_dev == NULL)
	printf ("Error: could not acc device \n");
	else
	printf ("Opened acc device \n");

	//
	// Attempts to debug
	//
	int foo, boo, loo;
	alt_u8 test = 0;
	foo = alt_up_accelerometer_spi_write(acc_dev, 0x31, 0x40);
	usleep(100000);	// 1sec
	boo = alt_up_accelerometer_spi_read(acc_dev, 0x00, &test);
	test = alt_up_accelerometer_spi_read_address_register(acc_dev, 0x00);
	usleep(100000);	// 1sec
	printf("test: %i\n", test);
	printf("foo: %i\n", foo);

	// original code
	//
	// accelerometer is supposed to reset enabled in +/- 2g mode
		int *xx;
		xx = (int*) malloc(sizeof(int));

		int *yy;
		yy = (int*) malloc(sizeof(int));

		int *zz;
		zz = (int*) malloc(sizeof(int));

	while(1){

	    if( alt_up_accelerometer_spi_read_x_axis(acc_dev, xx) == 0)
		printf("X is : %i\n", xx);

		if( alt_up_accelerometer_spi_read_y_axis(acc_dev, yy) == 0)
		printf("Y is : %i\n", yy);

		if( alt_up_accelerometer_spi_read_z_axis(acc_dev, zz) == 0)
		printf("Z is : %i\n", zz);

		usleep(100000);	// 1sec
		usleep(100000);	// 1sec

		xx = (int*) malloc(sizeof(int));
		yy = (int*) malloc(sizeof(int));
		zz = (int*) malloc(sizeof(int));
	}




	return 0;
}
