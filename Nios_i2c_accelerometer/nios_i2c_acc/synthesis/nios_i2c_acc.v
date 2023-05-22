// nios_i2c_acc.v

// Generated using ACDS version 22.1 915

`timescale 1 ps / 1 ps
module nios_i2c_acc (
		input  wire       clk_clk,                                   //                                clk.clk
		inout  wire       i2c_avalon_mm_if_0_conduit_end_scl_export, // i2c_avalon_mm_if_0_conduit_end_scl.export
		inout  wire       i2c_avalon_mm_if_0_conduit_end_sda_export, // i2c_avalon_mm_if_0_conduit_end_sda.export
		input  wire [2:0] interrupt_pio_external_connection_export,  //  interrupt_pio_external_connection.export
		output wire [9:0] led_pio_external_connection_export,        //        led_pio_external_connection.export
		input  wire       reset_reset_n,                             //                              reset.reset_n
		input  wire [9:0] sw_pio_external_connection_export          //         sw_pio_external_connection.export
	);

	wire  [31:0] cpu_data_master_readdata;                                       // mm_interconnect_0:cpu_data_master_readdata -> cpu:d_readdata
	wire         cpu_data_master_waitrequest;                                    // mm_interconnect_0:cpu_data_master_waitrequest -> cpu:d_waitrequest
	wire         cpu_data_master_debugaccess;                                    // cpu:debug_mem_slave_debugaccess_to_roms -> mm_interconnect_0:cpu_data_master_debugaccess
	wire  [19:0] cpu_data_master_address;                                        // cpu:d_address -> mm_interconnect_0:cpu_data_master_address
	wire   [3:0] cpu_data_master_byteenable;                                     // cpu:d_byteenable -> mm_interconnect_0:cpu_data_master_byteenable
	wire         cpu_data_master_read;                                           // cpu:d_read -> mm_interconnect_0:cpu_data_master_read
	wire         cpu_data_master_readdatavalid;                                  // mm_interconnect_0:cpu_data_master_readdatavalid -> cpu:d_readdatavalid
	wire         cpu_data_master_write;                                          // cpu:d_write -> mm_interconnect_0:cpu_data_master_write
	wire  [31:0] cpu_data_master_writedata;                                      // cpu:d_writedata -> mm_interconnect_0:cpu_data_master_writedata
	wire  [31:0] cpu_instruction_master_readdata;                                // mm_interconnect_0:cpu_instruction_master_readdata -> cpu:i_readdata
	wire         cpu_instruction_master_waitrequest;                             // mm_interconnect_0:cpu_instruction_master_waitrequest -> cpu:i_waitrequest
	wire  [19:0] cpu_instruction_master_address;                                 // cpu:i_address -> mm_interconnect_0:cpu_instruction_master_address
	wire         cpu_instruction_master_read;                                    // cpu:i_read -> mm_interconnect_0:cpu_instruction_master_read
	wire         cpu_instruction_master_readdatavalid;                           // mm_interconnect_0:cpu_instruction_master_readdatavalid -> cpu:i_readdatavalid
	wire         mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect;     // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_chipselect -> jtag_uart_0:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata;       // jtag_uart_0:av_readdata -> mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest;    // jtag_uart_0:av_waitrequest -> mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address;        // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_address -> jtag_uart_0:av_address
	wire         mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read;           // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_read -> jtag_uart_0:av_read_n
	wire         mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write;          // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_write -> jtag_uart_0:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata;      // mm_interconnect_0:jtag_uart_0_avalon_jtag_slave_writedata -> jtag_uart_0:av_writedata
	wire         mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_chipselect; // mm_interconnect_0:i2c_avalon_mm_if_0_avalon_slave_0_chipselect -> i2c_avalon_mm_if_0:chipselect
	wire  [31:0] mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_readdata;   // i2c_avalon_mm_if_0:readdata -> mm_interconnect_0:i2c_avalon_mm_if_0_avalon_slave_0_readdata
	wire   [2:0] mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_address;    // mm_interconnect_0:i2c_avalon_mm_if_0_avalon_slave_0_address -> i2c_avalon_mm_if_0:address
	wire         mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_read;       // mm_interconnect_0:i2c_avalon_mm_if_0_avalon_slave_0_read -> i2c_avalon_mm_if_0:read
	wire         mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_write;      // mm_interconnect_0:i2c_avalon_mm_if_0_avalon_slave_0_write -> i2c_avalon_mm_if_0:write
	wire  [31:0] mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_writedata;  // mm_interconnect_0:i2c_avalon_mm_if_0_avalon_slave_0_writedata -> i2c_avalon_mm_if_0:writedata
	wire  [31:0] mm_interconnect_0_cpu_debug_mem_slave_readdata;                 // cpu:debug_mem_slave_readdata -> mm_interconnect_0:cpu_debug_mem_slave_readdata
	wire         mm_interconnect_0_cpu_debug_mem_slave_waitrequest;              // cpu:debug_mem_slave_waitrequest -> mm_interconnect_0:cpu_debug_mem_slave_waitrequest
	wire         mm_interconnect_0_cpu_debug_mem_slave_debugaccess;              // mm_interconnect_0:cpu_debug_mem_slave_debugaccess -> cpu:debug_mem_slave_debugaccess
	wire   [8:0] mm_interconnect_0_cpu_debug_mem_slave_address;                  // mm_interconnect_0:cpu_debug_mem_slave_address -> cpu:debug_mem_slave_address
	wire         mm_interconnect_0_cpu_debug_mem_slave_read;                     // mm_interconnect_0:cpu_debug_mem_slave_read -> cpu:debug_mem_slave_read
	wire   [3:0] mm_interconnect_0_cpu_debug_mem_slave_byteenable;               // mm_interconnect_0:cpu_debug_mem_slave_byteenable -> cpu:debug_mem_slave_byteenable
	wire         mm_interconnect_0_cpu_debug_mem_slave_write;                    // mm_interconnect_0:cpu_debug_mem_slave_write -> cpu:debug_mem_slave_write
	wire  [31:0] mm_interconnect_0_cpu_debug_mem_slave_writedata;                // mm_interconnect_0:cpu_debug_mem_slave_writedata -> cpu:debug_mem_slave_writedata
	wire         mm_interconnect_0_onchip_mem_s1_chipselect;                     // mm_interconnect_0:onchip_mem_s1_chipselect -> onchip_mem:chipselect
	wire  [31:0] mm_interconnect_0_onchip_mem_s1_readdata;                       // onchip_mem:readdata -> mm_interconnect_0:onchip_mem_s1_readdata
	wire  [15:0] mm_interconnect_0_onchip_mem_s1_address;                        // mm_interconnect_0:onchip_mem_s1_address -> onchip_mem:address
	wire   [3:0] mm_interconnect_0_onchip_mem_s1_byteenable;                     // mm_interconnect_0:onchip_mem_s1_byteenable -> onchip_mem:byteenable
	wire         mm_interconnect_0_onchip_mem_s1_write;                          // mm_interconnect_0:onchip_mem_s1_write -> onchip_mem:write
	wire  [31:0] mm_interconnect_0_onchip_mem_s1_writedata;                      // mm_interconnect_0:onchip_mem_s1_writedata -> onchip_mem:writedata
	wire         mm_interconnect_0_onchip_mem_s1_clken;                          // mm_interconnect_0:onchip_mem_s1_clken -> onchip_mem:clken
	wire  [31:0] mm_interconnect_0_sw_pio_s1_readdata;                           // sw_pio:readdata -> mm_interconnect_0:sw_pio_s1_readdata
	wire   [1:0] mm_interconnect_0_sw_pio_s1_address;                            // mm_interconnect_0:sw_pio_s1_address -> sw_pio:address
	wire         mm_interconnect_0_led_pio_s1_chipselect;                        // mm_interconnect_0:led_pio_s1_chipselect -> led_pio:chipselect
	wire  [31:0] mm_interconnect_0_led_pio_s1_readdata;                          // led_pio:readdata -> mm_interconnect_0:led_pio_s1_readdata
	wire   [1:0] mm_interconnect_0_led_pio_s1_address;                           // mm_interconnect_0:led_pio_s1_address -> led_pio:address
	wire         mm_interconnect_0_led_pio_s1_write;                             // mm_interconnect_0:led_pio_s1_write -> led_pio:write_n
	wire  [31:0] mm_interconnect_0_led_pio_s1_writedata;                         // mm_interconnect_0:led_pio_s1_writedata -> led_pio:writedata
	wire         mm_interconnect_0_interrupt_pio_s1_chipselect;                  // mm_interconnect_0:interrupt_pio_s1_chipselect -> interrupt_pio:chipselect
	wire  [31:0] mm_interconnect_0_interrupt_pio_s1_readdata;                    // interrupt_pio:readdata -> mm_interconnect_0:interrupt_pio_s1_readdata
	wire   [1:0] mm_interconnect_0_interrupt_pio_s1_address;                     // mm_interconnect_0:interrupt_pio_s1_address -> interrupt_pio:address
	wire         mm_interconnect_0_interrupt_pio_s1_write;                       // mm_interconnect_0:interrupt_pio_s1_write -> interrupt_pio:write_n
	wire  [31:0] mm_interconnect_0_interrupt_pio_s1_writedata;                   // mm_interconnect_0:interrupt_pio_s1_writedata -> interrupt_pio:writedata
	wire         mm_interconnect_0_sys_clk_timer_s1_chipselect;                  // mm_interconnect_0:sys_clk_timer_s1_chipselect -> sys_clk_timer:chipselect
	wire  [15:0] mm_interconnect_0_sys_clk_timer_s1_readdata;                    // sys_clk_timer:readdata -> mm_interconnect_0:sys_clk_timer_s1_readdata
	wire   [2:0] mm_interconnect_0_sys_clk_timer_s1_address;                     // mm_interconnect_0:sys_clk_timer_s1_address -> sys_clk_timer:address
	wire         mm_interconnect_0_sys_clk_timer_s1_write;                       // mm_interconnect_0:sys_clk_timer_s1_write -> sys_clk_timer:write_n
	wire  [15:0] mm_interconnect_0_sys_clk_timer_s1_writedata;                   // mm_interconnect_0:sys_clk_timer_s1_writedata -> sys_clk_timer:writedata
	wire         irq_mapper_receiver0_irq;                                       // jtag_uart_0:av_irq -> irq_mapper:receiver0_irq
	wire         irq_mapper_receiver1_irq;                                       // sys_clk_timer:irq -> irq_mapper:receiver1_irq
	wire         irq_mapper_receiver2_irq;                                       // interrupt_pio:irq -> irq_mapper:receiver2_irq
	wire  [31:0] cpu_irq_irq;                                                    // irq_mapper:sender_irq -> cpu:irq
	wire         rst_controller_reset_out_reset;                                 // rst_controller:reset_out -> [cpu:reset_n, i2c_avalon_mm_if_0:reset_n, interrupt_pio:reset_n, irq_mapper:reset, jtag_uart_0:rst_n, led_pio:reset_n, mm_interconnect_0:cpu_reset_reset_bridge_in_reset_reset, onchip_mem:reset, rst_translator:in_reset, sw_pio:reset_n, sys_clk_timer:reset_n]
	wire         rst_controller_reset_out_reset_req;                             // rst_controller:reset_req -> [cpu:reset_req, onchip_mem:reset_req, rst_translator:reset_req_in]

	nios_i2c_acc_cpu cpu (
		.clk                                 (clk_clk),                                           //                       clk.clk
		.reset_n                             (~rst_controller_reset_out_reset),                   //                     reset.reset_n
		.reset_req                           (rst_controller_reset_out_reset_req),                //                          .reset_req
		.d_address                           (cpu_data_master_address),                           //               data_master.address
		.d_byteenable                        (cpu_data_master_byteenable),                        //                          .byteenable
		.d_read                              (cpu_data_master_read),                              //                          .read
		.d_readdata                          (cpu_data_master_readdata),                          //                          .readdata
		.d_waitrequest                       (cpu_data_master_waitrequest),                       //                          .waitrequest
		.d_write                             (cpu_data_master_write),                             //                          .write
		.d_writedata                         (cpu_data_master_writedata),                         //                          .writedata
		.d_readdatavalid                     (cpu_data_master_readdatavalid),                     //                          .readdatavalid
		.debug_mem_slave_debugaccess_to_roms (cpu_data_master_debugaccess),                       //                          .debugaccess
		.i_address                           (cpu_instruction_master_address),                    //        instruction_master.address
		.i_read                              (cpu_instruction_master_read),                       //                          .read
		.i_readdata                          (cpu_instruction_master_readdata),                   //                          .readdata
		.i_waitrequest                       (cpu_instruction_master_waitrequest),                //                          .waitrequest
		.i_readdatavalid                     (cpu_instruction_master_readdatavalid),              //                          .readdatavalid
		.irq                                 (cpu_irq_irq),                                       //                       irq.irq
		.debug_reset_request                 (),                                                  //       debug_reset_request.reset
		.debug_mem_slave_address             (mm_interconnect_0_cpu_debug_mem_slave_address),     //           debug_mem_slave.address
		.debug_mem_slave_byteenable          (mm_interconnect_0_cpu_debug_mem_slave_byteenable),  //                          .byteenable
		.debug_mem_slave_debugaccess         (mm_interconnect_0_cpu_debug_mem_slave_debugaccess), //                          .debugaccess
		.debug_mem_slave_read                (mm_interconnect_0_cpu_debug_mem_slave_read),        //                          .read
		.debug_mem_slave_readdata            (mm_interconnect_0_cpu_debug_mem_slave_readdata),    //                          .readdata
		.debug_mem_slave_waitrequest         (mm_interconnect_0_cpu_debug_mem_slave_waitrequest), //                          .waitrequest
		.debug_mem_slave_write               (mm_interconnect_0_cpu_debug_mem_slave_write),       //                          .write
		.debug_mem_slave_writedata           (mm_interconnect_0_cpu_debug_mem_slave_writedata),   //                          .writedata
		.dummy_ci_port                       ()                                                   // custom_instruction_master.readra
	);

	i2c_avalon_mm_if #(
		.GC_SYSTEM_CLK (50000000),
		.GC_I2C_CLK    (200000)
	) i2c_avalon_mm_if_0 (
		.clk        (clk_clk),                                                        //           clock.clk
		.reset_n    (~rst_controller_reset_out_reset),                                //           reset.reset_n
		.read       (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_read),       //  avalon_slave_0.read
		.write      (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_write),      //                .write
		.chipselect (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_chipselect), //                .chipselect
		.address    (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_address),    //                .address
		.writedata  (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_writedata),  //                .writedata
		.readdata   (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_readdata),   //                .readdata
		.sda        (i2c_avalon_mm_if_0_conduit_end_sda_export),                      // conduit_end_sda.export
		.scl        (i2c_avalon_mm_if_0_conduit_end_scl_export)                       // conduit_end_scl.export
	);

	nios_i2c_acc_interrupt_pio interrupt_pio (
		.clk        (clk_clk),                                       //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),               //               reset.reset_n
		.address    (mm_interconnect_0_interrupt_pio_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_interrupt_pio_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_interrupt_pio_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_interrupt_pio_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_interrupt_pio_s1_readdata),   //                    .readdata
		.in_port    (interrupt_pio_external_connection_export),      // external_connection.export
		.irq        (irq_mapper_receiver2_irq)                       //                 irq.irq
	);

	nios_i2c_acc_jtag_uart_0 jtag_uart_0 (
		.clk            (clk_clk),                                                     //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                             //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver0_irq)                                     //               irq.irq
	);

	nios_i2c_acc_led_pio led_pio (
		.clk        (clk_clk),                                 //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),         //               reset.reset_n
		.address    (mm_interconnect_0_led_pio_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_led_pio_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_led_pio_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_led_pio_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_led_pio_s1_readdata),   //                    .readdata
		.out_port   (led_pio_external_connection_export)       // external_connection.export
	);

	nios_i2c_acc_onchip_mem onchip_mem (
		.clk        (clk_clk),                                    //   clk1.clk
		.address    (mm_interconnect_0_onchip_mem_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_mem_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_mem_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_mem_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_mem_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_mem_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_mem_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),             // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),         //       .reset_req
		.freeze     (1'b0)                                        // (terminated)
	);

	nios_i2c_acc_sw_pio sw_pio (
		.clk      (clk_clk),                              //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),      //               reset.reset_n
		.address  (mm_interconnect_0_sw_pio_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_sw_pio_s1_readdata), //                    .readdata
		.in_port  (sw_pio_external_connection_export)     // external_connection.export
	);

	nios_i2c_acc_sys_clk_timer sys_clk_timer (
		.clk        (clk_clk),                                       //   clk.clk
		.reset_n    (~rst_controller_reset_out_reset),               // reset.reset_n
		.address    (mm_interconnect_0_sys_clk_timer_s1_address),    //    s1.address
		.writedata  (mm_interconnect_0_sys_clk_timer_s1_writedata),  //      .writedata
		.readdata   (mm_interconnect_0_sys_clk_timer_s1_readdata),   //      .readdata
		.chipselect (mm_interconnect_0_sys_clk_timer_s1_chipselect), //      .chipselect
		.write_n    (~mm_interconnect_0_sys_clk_timer_s1_write),     //      .write_n
		.irq        (irq_mapper_receiver1_irq)                       //   irq.irq
	);

	nios_i2c_acc_mm_interconnect_0 mm_interconnect_0 (
		.sys_clk_clk_clk                              (clk_clk),                                                        //                       sys_clk_clk.clk
		.cpu_reset_reset_bridge_in_reset_reset        (rst_controller_reset_out_reset),                                 //   cpu_reset_reset_bridge_in_reset.reset
		.cpu_data_master_address                      (cpu_data_master_address),                                        //                   cpu_data_master.address
		.cpu_data_master_waitrequest                  (cpu_data_master_waitrequest),                                    //                                  .waitrequest
		.cpu_data_master_byteenable                   (cpu_data_master_byteenable),                                     //                                  .byteenable
		.cpu_data_master_read                         (cpu_data_master_read),                                           //                                  .read
		.cpu_data_master_readdata                     (cpu_data_master_readdata),                                       //                                  .readdata
		.cpu_data_master_readdatavalid                (cpu_data_master_readdatavalid),                                  //                                  .readdatavalid
		.cpu_data_master_write                        (cpu_data_master_write),                                          //                                  .write
		.cpu_data_master_writedata                    (cpu_data_master_writedata),                                      //                                  .writedata
		.cpu_data_master_debugaccess                  (cpu_data_master_debugaccess),                                    //                                  .debugaccess
		.cpu_instruction_master_address               (cpu_instruction_master_address),                                 //            cpu_instruction_master.address
		.cpu_instruction_master_waitrequest           (cpu_instruction_master_waitrequest),                             //                                  .waitrequest
		.cpu_instruction_master_read                  (cpu_instruction_master_read),                                    //                                  .read
		.cpu_instruction_master_readdata              (cpu_instruction_master_readdata),                                //                                  .readdata
		.cpu_instruction_master_readdatavalid         (cpu_instruction_master_readdatavalid),                           //                                  .readdatavalid
		.cpu_debug_mem_slave_address                  (mm_interconnect_0_cpu_debug_mem_slave_address),                  //               cpu_debug_mem_slave.address
		.cpu_debug_mem_slave_write                    (mm_interconnect_0_cpu_debug_mem_slave_write),                    //                                  .write
		.cpu_debug_mem_slave_read                     (mm_interconnect_0_cpu_debug_mem_slave_read),                     //                                  .read
		.cpu_debug_mem_slave_readdata                 (mm_interconnect_0_cpu_debug_mem_slave_readdata),                 //                                  .readdata
		.cpu_debug_mem_slave_writedata                (mm_interconnect_0_cpu_debug_mem_slave_writedata),                //                                  .writedata
		.cpu_debug_mem_slave_byteenable               (mm_interconnect_0_cpu_debug_mem_slave_byteenable),               //                                  .byteenable
		.cpu_debug_mem_slave_waitrequest              (mm_interconnect_0_cpu_debug_mem_slave_waitrequest),              //                                  .waitrequest
		.cpu_debug_mem_slave_debugaccess              (mm_interconnect_0_cpu_debug_mem_slave_debugaccess),              //                                  .debugaccess
		.i2c_avalon_mm_if_0_avalon_slave_0_address    (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_address),    // i2c_avalon_mm_if_0_avalon_slave_0.address
		.i2c_avalon_mm_if_0_avalon_slave_0_write      (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_write),      //                                  .write
		.i2c_avalon_mm_if_0_avalon_slave_0_read       (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_read),       //                                  .read
		.i2c_avalon_mm_if_0_avalon_slave_0_readdata   (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_readdata),   //                                  .readdata
		.i2c_avalon_mm_if_0_avalon_slave_0_writedata  (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_writedata),  //                                  .writedata
		.i2c_avalon_mm_if_0_avalon_slave_0_chipselect (mm_interconnect_0_i2c_avalon_mm_if_0_avalon_slave_0_chipselect), //                                  .chipselect
		.interrupt_pio_s1_address                     (mm_interconnect_0_interrupt_pio_s1_address),                     //                  interrupt_pio_s1.address
		.interrupt_pio_s1_write                       (mm_interconnect_0_interrupt_pio_s1_write),                       //                                  .write
		.interrupt_pio_s1_readdata                    (mm_interconnect_0_interrupt_pio_s1_readdata),                    //                                  .readdata
		.interrupt_pio_s1_writedata                   (mm_interconnect_0_interrupt_pio_s1_writedata),                   //                                  .writedata
		.interrupt_pio_s1_chipselect                  (mm_interconnect_0_interrupt_pio_s1_chipselect),                  //                                  .chipselect
		.jtag_uart_0_avalon_jtag_slave_address        (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address),        //     jtag_uart_0_avalon_jtag_slave.address
		.jtag_uart_0_avalon_jtag_slave_write          (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write),          //                                  .write
		.jtag_uart_0_avalon_jtag_slave_read           (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read),           //                                  .read
		.jtag_uart_0_avalon_jtag_slave_readdata       (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata),       //                                  .readdata
		.jtag_uart_0_avalon_jtag_slave_writedata      (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata),      //                                  .writedata
		.jtag_uart_0_avalon_jtag_slave_waitrequest    (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest),    //                                  .waitrequest
		.jtag_uart_0_avalon_jtag_slave_chipselect     (mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect),     //                                  .chipselect
		.led_pio_s1_address                           (mm_interconnect_0_led_pio_s1_address),                           //                        led_pio_s1.address
		.led_pio_s1_write                             (mm_interconnect_0_led_pio_s1_write),                             //                                  .write
		.led_pio_s1_readdata                          (mm_interconnect_0_led_pio_s1_readdata),                          //                                  .readdata
		.led_pio_s1_writedata                         (mm_interconnect_0_led_pio_s1_writedata),                         //                                  .writedata
		.led_pio_s1_chipselect                        (mm_interconnect_0_led_pio_s1_chipselect),                        //                                  .chipselect
		.onchip_mem_s1_address                        (mm_interconnect_0_onchip_mem_s1_address),                        //                     onchip_mem_s1.address
		.onchip_mem_s1_write                          (mm_interconnect_0_onchip_mem_s1_write),                          //                                  .write
		.onchip_mem_s1_readdata                       (mm_interconnect_0_onchip_mem_s1_readdata),                       //                                  .readdata
		.onchip_mem_s1_writedata                      (mm_interconnect_0_onchip_mem_s1_writedata),                      //                                  .writedata
		.onchip_mem_s1_byteenable                     (mm_interconnect_0_onchip_mem_s1_byteenable),                     //                                  .byteenable
		.onchip_mem_s1_chipselect                     (mm_interconnect_0_onchip_mem_s1_chipselect),                     //                                  .chipselect
		.onchip_mem_s1_clken                          (mm_interconnect_0_onchip_mem_s1_clken),                          //                                  .clken
		.sw_pio_s1_address                            (mm_interconnect_0_sw_pio_s1_address),                            //                         sw_pio_s1.address
		.sw_pio_s1_readdata                           (mm_interconnect_0_sw_pio_s1_readdata),                           //                                  .readdata
		.sys_clk_timer_s1_address                     (mm_interconnect_0_sys_clk_timer_s1_address),                     //                  sys_clk_timer_s1.address
		.sys_clk_timer_s1_write                       (mm_interconnect_0_sys_clk_timer_s1_write),                       //                                  .write
		.sys_clk_timer_s1_readdata                    (mm_interconnect_0_sys_clk_timer_s1_readdata),                    //                                  .readdata
		.sys_clk_timer_s1_writedata                   (mm_interconnect_0_sys_clk_timer_s1_writedata),                   //                                  .writedata
		.sys_clk_timer_s1_chipselect                  (mm_interconnect_0_sys_clk_timer_s1_chipselect)                   //                                  .chipselect
	);

	nios_i2c_acc_irq_mapper irq_mapper (
		.clk           (clk_clk),                        //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.receiver1_irq (irq_mapper_receiver1_irq),       // receiver1.irq
		.receiver2_irq (irq_mapper_receiver2_irq),       // receiver2.irq
		.sender_irq    (cpu_irq_irq)                     //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.clk            (clk_clk),                            //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule