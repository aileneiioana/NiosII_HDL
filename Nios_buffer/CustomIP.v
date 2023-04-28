module CustomIP(
	input [9:0] address,
	input chipselect,
	input clk,
	input read,
	input reset_n,
	input write,
	input [31:0] writedata,
	output reg [31:0] readdata
);
   
   reg [31:0] mem[1023:0]; 
   
	   always@(posedge clk or negedge reset_n)
	   begin
		if(reset_n == 1'b0) 
		begin
			readdata<=32'b0;
		end
		else if (chipselect && write)
		begin
			mem[address] <= writedata;
		end
		else if (chipselect && read)
		begin
			readdata <= mem[address];
		end
    end
endmodule