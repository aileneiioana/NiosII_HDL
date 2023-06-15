// ============================================================================
//   Ver  :| Author					:| Mod. Date :| Changes Made:
//   V1.1 :| Alexandra Du			:| 06/01/2016:| Added Verilog file
// ============================================================================


//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

`define ENABLE_ADC_CLOCK
`define ENABLE_CLOCK1
`define ENABLE_CLOCK2
`define ENABLE_SDRAM
`define ENABLE_HEX0
`define ENABLE_HEX1
`define ENABLE_HEX2
`define ENABLE_HEX3
`define ENABLE_HEX4
`define ENABLE_HEX5
`define ENABLE_KEY
`define ENABLE_LED
`define ENABLE_SW
`define ENABLE_VGA
`define ENABLE_ACCELEROMETER
`define ENABLE_ARDUINO
`define ENABLE_GPIO

module DE10_LITE_Golden_Top(

	//////////// ADC CLOCK: 3.3-V LVTTL //////////
`ifdef ENABLE_ADC_CLOCK
	input 		          		ADC_CLK_10,
`endif
	//////////// CLOCK 1: 3.3-V LVTTL //////////
`ifdef ENABLE_CLOCK1
	input 		          		MAX10_CLK1_50,
`endif
	//////////// CLOCK 2: 3.3-V LVTTL //////////
`ifdef ENABLE_CLOCK2
	input 		          		MAX10_CLK2_50,
`endif

	//////////// SDRAM: 3.3-V LVTTL //////////
`ifdef ENABLE_SDRAM
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,
`endif

	//////////// SEG7: 3.3-V LVTTL //////////
`ifdef ENABLE_HEX0
	output		     [7:0]		HEX0,
`endif
`ifdef ENABLE_HEX1
	output		     [7:0]		HEX1,
`endif
`ifdef ENABLE_HEX2
	output		     [7:0]		HEX2,
`endif
`ifdef ENABLE_HEX3
	output		     [7:0]		HEX3,
`endif
`ifdef ENABLE_HEX4
	output		     [7:0]		HEX4,
`endif
`ifdef ENABLE_HEX5
	output		     [7:0]		HEX5,
`endif

	//////////// KEY: 3.3 V SCHMITT TRIGGER //////////
`ifdef ENABLE_KEY
	input 		     [1:0]		KEY,
`endif

	//////////// LED: 3.3-V LVTTL //////////
`ifdef ENABLE_LED
	output		     [9:0]		LEDR,
`endif

	//////////// SW: 3.3-V LVTTL //////////
`ifdef ENABLE_SW
	input 		     [9:0]		SW,
`endif

	//////////// VGA: 3.3-V LVTTL //////////
`ifdef ENABLE_VGA
	output		     [3:0]		VGA_B,
	output		     [3:0]		VGA_G,
	output		          		VGA_HS,
	output		     [3:0]		VGA_R,
	output		          		VGA_VS,
`endif

	//////////// Accelerometer: 3.3-V LVTTL //////////
`ifdef ENABLE_ACCELEROMETER
	output		          		GSENSOR_CS_N,
	input 		     [2:1]		GSENSOR_INT,
	output		          		GSENSOR_SCLK,
	inout 		          		GSENSOR_SDI,
	inout 		          		GSENSOR_SDO,
`endif

	//////////// Arduino: 3.3-V LVTTL //////////
`ifdef ENABLE_ARDUINO
	inout 		    [15:0]		ARDUINO_IO,
	inout 		          		ARDUINO_RESET_N,
`endif

	//////////// GPIO, GPIO connect to GPIO Default: 3.3-V LVTTL //////////
`ifdef ENABLE_GPIO
	inout 		    [35:0]		GPIO
`endif
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

m21 m21_i (1'b0, 1'b1, SW[9], LEDR[9]); 


//=======================================================
//  REG/WIRE declarations
//=======================================================

wire[12:0] number; // bcd reprezentation of switch number; SW[9] is the sign 
wire[ 3:0] digit;  // units digit
wire[ 3:0] dec;    // tens digit
wire[ 3:0] cen;    // hundreads digit
wire[ 3:0] sig;    // sign digit; 1 - minus, 0 - plus
wire[ 9:0] binary; // module of number in binary representation
//=======================================================
//  Structural coding
//=======================================================

//extract sign & take module; if SW is 1000000000 is -512 & the formula is not applied
assign binary =   (SW[9])?  {SW[9], (~SW[8:0] + 'b1)} : SW;


//convert the switch binary number into bcd 
bin2bcd i_bin2bcd(.bin(binary[8:0]), 
                  .bcd(number));

//if number is -512 digit is 2, else digit is always represented 	
assign digit = (SW=='b1000000000)? 'b0010 : number [3:0];
// if number is -512 tens is 1
// tens is represented if the number is greater than 9
// and also if the number is a digit and is negative minus has to be displayed: 'b1010 - minus   
assign dec = (SW=='b1000000000)? 'b0001 :((SW[9] &&  binary[8:0] <= 'd9 && binary[8:0] > 'b0)   ? 'b1010: ((binary[8:0] > 'd9)    ? number[7:4]  : 'b1111));
// if number is -512 hundreads is 5
// hundreads is represented if the number is greater than 99
// and also if the number is not greater than 99 and is negative minus has to be displayed 
assign cen =(SW=='b1000000000)? 'b0101 : ((SW[9] && binary[8:0] <= 'd99 && binary[8:0] > 'd9)? 'b1010: ((number[12:8]) ? number[12:8] : 'b1111));
// if number is -512 sign is -
// sign displayed here just if the number is a 3 digits negative number
assign sig = ((SW[9] && binary[8:0] > 'd99)||(SW=='b1000000000)) ? 'b1010: 'b1111;
						
segment7 i_digit2seg( .bcd(digit), 
                      .seg(HEX0));
							 						 
segment7 i_dec2seg  ( .bcd(dec), 
                      .seg(HEX1));
							 
segment7 i_cen2seg  ( .bcd(cen), 
                      .seg(HEX2));

segment7 i_sig2seg  ( .bcd(sig), 
                      .seg(HEX3));	
							 
assign HEX4 = 'b111111111;
assign HEX5 = 'b111111111;



endmodule
