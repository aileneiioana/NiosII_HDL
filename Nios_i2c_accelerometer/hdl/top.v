module top;

  reg clk;
  reg reset_n;
  reg read,  write,  chipselect;
  reg [2:0] address;
  reg [31:0] writedata;
  wire [31:0] readdata;
  wire sda, scl;
 
i2c_avalon_mm_if i2c_avalon_mm_if_i (
  .clk(clk), 
  .reset_n(reset_n), 
  .read(read), 
  .write(write), 
  .chipselect(chipselect), 
  .address(address), 
  .writedata(writedata), 
  .readdata(readdata), 
  .sda(sda), 
  .scl(scl)
);
	initial begin
		clk <= 1'b0;
		forever begin
		  #1 clk <= ~clk;
		end
	end
	initial begin
		reset_n <= 1'b1;
		repeat(3) @(posedge clk);
		reset_n <= 1'b0;
		repeat(3) @(posedge clk);
		reset_n <= 1'b1;
	end
	
	initial begin
		read <= 1'b0;
		write <= 1'b0;
		chipselect <= 1'b0;
		address <= 3'b010;
		writedata <= 'b0;
		repeat(10) @(posedge clk);
		
		write      <= 1'b1;
		chipselect <= 1'b1;
		address  <= 'h00;
		writedata<= 'h53;
	    repeat(10)@(posedge clk);
		
		chipselect <= 1'b0;
		write <= 1'b0;
		repeat(10)@(posedge clk);
		wait(i2c_avalon_mm_if_i.mm_if_busy_state == 'b0);
		$display("done");

		write      <= 1'b1;
		chipselect <= 1'b1;
		address  <= 'b01;
		writedata<= 'b1010011;
	    @(posedge clk);
		
		chipselect <= 1'b0;
		write <= 1'b0;
		repeat(10)@(posedge clk);
		wait(i2c_avalon_mm_if_i.mm_if_busy_state == 'b0);
		$display("done");
		
		write      <= 1'b1;
		chipselect <= 1'b1;
		address  <= 'b10;
		writedata<= 'b1010011;
	    @(posedge clk);
		
		chipselect <= 1'b0;
		write <= 1'b0;
		 repeat(10)@(posedge clk);
		wait(i2c_avalon_mm_if_i.mm_if_busy_state == 'b0);
		$display("done");
		
		read      <= 1'b1;
		chipselect <= 1'b1;
		address  <= 'b10;
	    @(posedge clk);
		
		chipselect <= 1'b0;
		read <= 1'b0;
		repeat(10) @(posedge clk);
		wait(i2c_avalon_mm_if_i.mm_if_busy_state == 'b0);
		$display("done");
		
		$finish;
	
	end
endmodule