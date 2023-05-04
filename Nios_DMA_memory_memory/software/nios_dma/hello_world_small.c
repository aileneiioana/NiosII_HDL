#include "system.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/alt_cache.h>
#include <sys/alt_irq.h>
// mSGDMA transfer related
#include <altera_msgdma_descriptor_regs.h>
#include <altera_msgdma_csr_regs.h>
#include <altera_msgdma.h>

#define MSGDMA_NAME (MSGDMA_CSR_NAME)
#define OCRAM0_BASE (OCRAM_0_BASE)
#define OCRAM1_BASE (OCRAM_1_BASE)

//macros
#define TRUE -1
#define FALSE 0
#define USE_ASYNC_XFER TRUE
#define XFER_BYTES 1024

//global variables
volatile int xfer_cmp = FALSE;
volatile int xfer_err = FALSE;

//functions
void msgdma_callback( void* context );
void init_ram( unsigned char *p_rd_adrs, unsigned char *p_wr_adrs, int bytes );
void dump_ram( unsigned char *p_ram_adrs, int bytes );
int verify_ram( unsigned char *p_rd_adrs, unsigned char *p_wr_adrs, int bytes );


int main()
{
 alt_msgdma_dev *p_msgdma;
 alt_msgdma_standard_descriptor msgdma_desc;
 unsigned char *p_dma_rd;
 unsigned char *p_dma_wr;
 int status = 0;

 p_dma_rd = (unsigned char*)( OCRAM0_BASE | 0x80000000 );

 p_dma_wr = (unsigned char*)( OCRAM1_BASE | 0x80000000 );
 printf("<< Start Program!! >>\n");

 init_ram( p_dma_rd, p_dma_wr, XFER_BYTES );

 printf( "\n<Debug> On-Chip RAM 0 Contents Before DMA!!\n" );
 dump_ram( p_dma_rd, XFER_BYTES );

 printf( "\n<Debug> On-Chip RAM 1 Contents Before DMA!!\n" );
 dump_ram( p_dma_wr, XFER_BYTES );

 p_msgdma = alt_msgdma_open( MSGDMA_NAME );
 if ( p_msgdma == NULL )
 {
 printf( "Error: Could not open the mSGDMA\n" );
 return -1;
 }
 // alt_msgdma_irq()
  alt_msgdma_register_callback( p_msgdma,
  msgdma_callback,
  ALTERA_MSGDMA_CSR_GLOBAL_INTERRUPT_MASK |
  ALTERA_MSGDMA_CSR_STOP_ON_ERROR_MASK |
  ALTERA_MSGDMA_CSR_STOP_ON_EARLY_TERMINATION_MASK,
  p_msgdma );

  alt_dcache_flush_all();

  status = alt_msgdma_construct_standard_mm_to_mm_descriptor( p_msgdma,
  &msgdma_desc,
  (alt_u32*)p_dma_rd,
  (alt_u32*)p_dma_wr,
  XFER_BYTES,
  ALTERA_MSGDMA_DESCRIPTOR_CONTROL_TRANSFER_COMPLETE_IRQ_MASK );
  if( status != 0 )
  {
  printf( "Error: mSGDMA descriptor Fail[%d]\n", status );
  return status;
  }

  printf( "\n<Debug> mSGDMA Transfer Start!!\n" );
 #if USE_ASYNC_XFER
  status = alt_msgdma_standard_descriptor_async_transfer( p_msgdma, &msgdma_desc );
  if ( 0 != status )
  {
  printf( "Error: mSGDMA async_transfer Fail[%d]\n", status );
  return status;
  }

  while (1)
  {

  if ( xfer_cmp == TRUE )
  break;

  if ( xfer_err )
  break;
  }
 #else
  status = alt_msgdma_standard_descriptor_sync_transfer( p_msgdma, &msgdma_desc );
  if ( 0 != status )
  {
  printf( "Error: mSGDMA sync_transfer Fail[%d]\n", status );
  return status;
  }
 #endif

  printf( "\n<Debug> On-Chip RAM 0 Contents After DMA!!\n" );
  dump_ram( p_dma_rd, XFER_BYTES );

  printf( "\n<Debug> On-Chip RAM 1 Contents After DMA!!\n" );
  dump_ram( p_dma_wr, XFER_BYTES );
  printf( "\n<Debug> On-Chip RAM 0 and 1 Contents Verify!!\n" );
   status = verify_ram( p_dma_rd, p_dma_wr, XFER_BYTES );
   if ( 0 != status )
   printf( "<Debug> Data Verify Error!!\n" );
   else
   printf( "<Debug> Data Verify OK!!\n" );
   return status;
  }

  void msgdma_callback( void* context )
  {
   struct alt_msgdma_dev *p_msgdma = (alt_msgdma_dev*)context;
   printf( "<Debug> mSGDMA Callback Function called!!\n" );

   int nCtrl = IORD_ALTERA_MSGDMA_CSR_CONTROL( p_msgdma->csr_base );
   int nStat = IORD_ALTERA_MSGDMA_CSR_STATUS( p_msgdma->csr_base );

   if ( nStat & ALTERA_MSGDMA_CSR_DESCRIPTOR_BUFFER_EMPTY_MASK )
   {

   xfer_cmp = TRUE;
   }
   else
   {

   xfer_err = TRUE;
   printf( " mSGDMA_IRQ: stat_reg=%X. ctrl_reg=%X\n", nStat, nCtrl );
   }
  }

  void init_ram( unsigned char *p_rd_adrs, unsigned char *p_wr_adrs, int bytes )
  {
   int i;
   for ( i = 0; i < bytes; i++ )
   {

   p_rd_adrs[i] = rand();
   }

   memset( p_wr_adrs, 0x00, bytes );
  }
  void dump_ram( unsigned char *p_ram_adrs, int bytes )
  {
   int i;
   unsigned char ucData;

   alt_dcache_flush_all();
   printf( "\n0000: " );
   for ( i = 0; i < bytes; i++ )
   {
   ucData = p_ram_adrs[i];
   if(( i % 16 == 15 ) && ( i < bytes - 1 ))
   printf( "%02X \n%04X: ", ucData, i + 1 );
   else
   printf( "%02X ", ucData );
   }
   printf( "\n" );
  }

  int verify_ram( unsigned char *p_rd_adrs, unsigned char *p_wr_adrs, int bytes )
  {
   int i;
   int status = 0;
   for ( i = 0; i < bytes; i++ )
   {
   if ( p_rd_adrs[i] != p_wr_adrs[i] )
   {
   printf( "<Debug> Data Verify Error!! Address = %05d\n", (unsigned int)i );
   status = -1;
   }
   }
   return status;
  }


