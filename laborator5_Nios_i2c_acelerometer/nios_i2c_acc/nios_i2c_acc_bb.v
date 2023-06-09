
module nios_i2c_acc (
	clk_clk,
	i2c_avalon_mm_if_0_conduit_end_scl_export,
	i2c_avalon_mm_if_0_conduit_end_sda_export,
	interrupt_pio_external_connection_export,
	led_pio_external_connection_export,
	reset_reset_n,
	sw_pio_external_connection_export);	

	input		clk_clk;
	inout		i2c_avalon_mm_if_0_conduit_end_scl_export;
	inout		i2c_avalon_mm_if_0_conduit_end_sda_export;
	input	[2:0]	interrupt_pio_external_connection_export;
	output	[9:0]	led_pio_external_connection_export;
	input		reset_reset_n;
	input	[9:0]	sw_pio_external_connection_export;
endmodule
