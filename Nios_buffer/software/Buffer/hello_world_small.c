#include <stdio.h>
#include <system.h>
#include <io.h>

int main (void){

	int i;
	int data =0;
	printf("Welcome to Custom IP Buffer Demo!\n");

	for(int i=0;i<1024;i++)
	IOWR(MYBUFFER_BASE, i, ++data);

	for(int i=0;i<1024;i++)
	printf("Custom Reg %d: %d\n", i, IORD(MYBUFFER_BASE, i));

	printf("\nNow lets modify all data *10\n");
	for(int i=0;i<1024;i++)
     IOWR(MYBUFFER_BASE, i, (IORD(MYBUFFER_BASE, i)*10));

	for(int i=0;i<1024;i++)
		printf("Custom Reg %d: %d\n", i, IORD(MYBUFFER_BASE, i));
	while(1){

	}

	return 0;
}
