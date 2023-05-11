  #Toggle switches
        set_location_assignment PIN_C10 -to sw[0]
		set_location_assignment PIN_C11 -to sw[1]
		set_location_assignment PIN_D12 -to sw[2]
		set_location_assignment PIN_C12 -to sw[3]
		set_location_assignment PIN_A12 -to sw[4]
		set_location_assignment PIN_B12 -to sw[5]
		set_location_assignment PIN_A13 -to sw[6]
		set_location_assignment PIN_A14 -to sw[7]
		set_location_assignment PIN_B14 -to sw[8]
		set_location_assignment PIN_F15 -to sw[9]


        # YOUR TASK: Enter the pin assignments for the remaining SW pins

        #LED outputs
        set_location_assignment PIN_A8 -to led[0]
		set_location_assignment PIN_A9 -to led[1]
		set_location_assignment PIN_A10 -to led[2]
		set_location_assignment PIN_B10 -to led[3]
		set_location_assignment PIN_D13 -to led[4]
		set_location_assignment PIN_C13 -to led[5]
		set_location_assignment PIN_E14 -to led[6]
		set_location_assignment PIN_D14 -to led[7]
		set_location_assignment PIN_A11 -to led[8]
		set_location_assignment PIN_B11 -to led[9]
		
		
		
		#50MHz clock MAX10_CLK1_50
		set_location_assignment PIN_P11 -to clk

		#External asynchronous inputs
		#Push buttons for external reset and key
		#key0 - used as reset
		set_location_assignment PIN_B8 -to arst_n
		#key1
		set_location_assignment PIN_A7 -to ext_ena_n  
		#----------------------------------------------
		#Hentet fra løsningsforslag
		# SDA and SCL lines
		set_location_assignment PIN_V11 -to sda
		set_location_assignment PIN_AB15 -to scl

		# if using GSENSOR interrupt
		set_location_assignment PIN_Y14 -to adxl345_irq_n[0]
		set_location_assignment PIN_Y13 -to adxl345_irq_n[1]

		# GSENSOR
		# cs_n=1 -> I2C-mode, cs_n=0 -> SPI-mode
		set_location_assignment PIN_AB16 -to adxl345_cs_n

		# if GSENSOR I2C
		# With the ALT ADDRESS pin high, the 7-bit I2C address for the device is 0x1D, followed by the R/W # bit. This translates to 0x3A for a write and 0x3B for a read. An alternate I2C address of 0x53 (followed by the R/W bit) can be chosen by grounding the ALT ADDRESS pin (Pin 12). This translates #to 0xA6 for a write and 0xA7 for a read.
		set_location_assignment PIN_V12 -to adxl345_alt_addr
		#--------------------------------------------------

		#To avoid that the FPGA is driving an unintended value on pins that are not in use:
		set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
