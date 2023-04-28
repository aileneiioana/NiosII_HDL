#include <stdio.h>
#include <system.h>

int main(void){

	unsigned int a = 0xffffffff;
	unsigned int b = 0x11111111;
	unsigned result = 0;

	printf("Hello! Welcome to Custom Instruction!\n");

	result = ALT_CI_MYAND_0(a,b);

	printf("a = 0x%x, b = 0x%x, result = 0x%x\n ", a, b, result);
	while(1){}
	return 0;
}
