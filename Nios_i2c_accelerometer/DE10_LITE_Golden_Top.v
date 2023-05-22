module DE10_LITE_Golden_Top(
    input clk,
    input arst_n,
    input [9:0] sw,
    output [9:0] led,
    inout sda,
    inout scl,
    output adxl345_alt_addr,
    output adxl345_cs_n,
    input [1:0] adxl345_irq_n,
    input ext_ena_n
);

    // Declare signals for internal use
    reg [2:0] irq_n_r, irq_n_rr;
    reg arst_n_r, rst_n;

    // Instantiate nios2_system module
    nios_i2c_acc u0(
        .clk_clk(clk),
        .sw_pio_external_connection_export(sw),
        .led_pio_external_connection_export(led),
        .interrupt_pio_external_connection_export(irq_n_rr),
        .reset_reset_n(rst_n),
        .i2c_avalon_mm_if_0_conduit_end_scl_export(scl),
        .i2c_avalon_mm_if_0_conduit_end_sda_export(sda)
    );
	 


    // Set ADXL345's I2C address to 0x53
    assign adxl345_alt_addr = 1'b0;
    // Set ADXL345's mode to I2C
    assign adxl345_cs_n = 1'b1;

    // Synchronous reset process
    always @(posedge clk) begin
        if (arst_n == 1'b0) begin
            arst_n_r <= 1'b0;
            rst_n <= 1'b0;
        end else begin
            arst_n_r <= 1'b1;
            rst_n <= arst_n_r;
        end
    end

    // Synchronization process for adxl345_irq_n and ext_ena_n
    always @(posedge clk) begin
        irq_n_r <= {adxl345_irq_n, ext_ena_n};
        irq_n_rr <= irq_n_r;
    end

endmodule