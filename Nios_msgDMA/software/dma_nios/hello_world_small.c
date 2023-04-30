#include <stdio.h>
#include "altera_msgdma_descriptor_regs.h"
#include "altera_msgdma_prefetcher_regs.h"
#include "altera_msgdma_csr_regs.h"
#include "altera_msgdma.h"
#include "system.h"

//Modular Scatter-Gather DMA Defines
alt_msgdma_dev *STDATA_MSGDMA;
alt_msgdma_standard_descriptor STDATA_MSGDMA_DESC;

#define LEN 100

alt_u32 *WRITE_ADDRESS = DATA_DESTINATION_BASE;

int main()
{ 
  //alt_putstr("Hello from Nios II!\n");
  // 1- Initialize the Data Pattern Generator, by defining the pattern required for testing.
  IOWR(DATA_SOURCE_BASE, 1, 0x2); //to choose the preferred data pattern

  IOWR(DATA_SOURCE_BASE, 0, 1); //to Enable the Pattern Generator

  //2- Open the msgdma
  STDATA_MSGDMA = alt_msgdma_open(MSGDMA_0_CSR_NAME);
  if(STDATA_MSGDMA == NULL)
	  printf("Could not open the msgDMA\n");

  //3- Construct the DMA desc
  alt_msgdma_construct_standard_st_to_mm_descriptor(
		  STDATA_MSGDMA,
		  &STDATA_MSGDMA_DESC,
		  WRITE_ADDRESS,
		  LEN,
		  ALTERA_MSGDMA_DESCRIPTOR_CONTROL_PARK_WRITES_MASK);

  //4- Run the msgdma
  alt_msgdma_standard_descriptor_async_transfer(STDATA_MSGDMA, &STDATA_MSGDMA_DESC);
  /* Event loop never exits. */
  while (1);

  return 0;
}
