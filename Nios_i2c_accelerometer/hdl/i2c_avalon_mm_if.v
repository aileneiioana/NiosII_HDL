module i2c_avalon_mm_if (
  input clk, 
  input reset_n, 
  input read, 
  input write, 
  input chipselect, 
  input [2:0] address, 
  input [31:0] writedata, 
  output reg [31:0] readdata, 
  inout sda, 
  inout scl
);
  //R: Read only register
  //W: Write only register
  //RW: Read and write register

  reg [31:0] ctrl_reg  ;  //RW
  reg [31:0] addr_reg  ;  //RW
  reg [31:0] write_reg ;  //RW
  reg [63:0] read_reg  ;  //R
  
  parameter GC_SYSTEM_CLK = 50000000;
  parameter GC_I2C_CLK    = 200000;
  
  localparam sIDLE = 3'b000;
  localparam sADDR = 3'b001;
  localparam sWRITE_DATA= 3'b010;
  localparam sWAIT_DATA= 3'b011;
  localparam sWAIT_STOP= 3'b100;
  
    //i2c master signals
  reg        i2c_valid;
  reg  [6:0] i2c_addr;
  reg        i2c_rnw;
  reg  [7:0] i2c_data_wr;
  wire       i2c_busy;
  wire [7:0] i2c_data_rd;
  wire       i2c_ack_error;
  
  reg [3:0] state;
  
  reg [3:0] byte_count;
  
  reg mm_if_busy_state;
  
  
  i2c_master #(GC_SYSTEM_CLK,GC_I2C_CLK) i2c_master_inst
    (
      .clk       (clk),
      .arst_n    (reset_n),
      .valid     (i2c_valid),
      .addr      (i2c_addr),
      .rnw       (i2c_rnw),
      .data_wr   (i2c_data_wr),
      .busy      (i2c_busy),
      .data_rd   (i2c_data_rd),
      .ack_error (i2c_ack_error),
      .sda       (sda),
      .scl       (scl)
      );
	  
	  reg cmd_rst;

always @(posedge clk or negedge reset_n)begin
	if(~reset_n) begin
		ctrl_reg  <= 'b0;
		addr_reg  <= 'b0;
		write_reg <= 'b0;
	end 
	else 
		if(cmd_rst) begin 
			ctrl_reg[0] <= 1'b0;
			ctrl_reg[6]<= i2c_busy;
		    ctrl_reg[5]<= i2c_ack_error;
		    ctrl_reg[7]<= mm_if_busy_state;
			end
		else
       // Write data from CPU interface
        if (chipselect && write)begin
				ctrl_reg[6]<= i2c_busy;
				ctrl_reg[5]<= i2c_ack_error;
				ctrl_reg[7]<= mm_if_busy_state;
			case (address)
			  3'b000:
				ctrl_reg[4:0] <= writedata[4:0];
			  3'b001:
				addr_reg <= writedata;
			  3'b010 :
				write_reg[31:0] <= writedata;
			endcase
			end
	    // Read data to CPU interface
        else if(chipselect && read ) begin
				ctrl_reg[6]<= i2c_busy;
		ctrl_reg[5]<= i2c_ack_error;
		ctrl_reg[7]<= mm_if_busy_state;
			case (address) 
			  3'b000:
				readdata <= ctrl_reg;
			  3'b001:
				readdata <= addr_reg;
			  3'b010:
				readdata <= write_reg[31:0];
			  3'b011:
				readdata <= read_reg[31:0];
			  3'b100:
				readdata <= read_reg[63:32];
			  default:
				readdata <= read_reg[31:0];
			endcase
			end
	end


 always@(posedge clk or negedge reset_n) begin
	if(~reset_n)begin
	  state              <= sIDLE;
      i2c_rnw            <= 1'b0;
      i2c_data_wr        <= 'b0;
      i2c_valid          <= 1'b0;
      i2c_addr           <= 'b0;
      byte_count         <=  'b0;
      read_reg           <=  'b0;
      mm_if_busy_state   <= 1'b0;
	  cmd_rst            <= 1'b0;
	end
	else begin
	
		case (state) 
			sIDLE: begin
				byte_count         <= 'b0;
				i2c_valid          <= 1'b0;
				i2c_rnw            <= 1'b0;
				i2c_data_wr        <=  'b0;
				i2c_addr           <=  'b0;
				mm_if_busy_state   <= 1'b0;
				if(ctrl_reg[0]) begin
					state              <= sADDR;
                    cmd_rst            <=1'b1;
                    mm_if_busy_state   <=1'b1;
				end
			end
//-------------------------------------------------------------------------------
//-- sADDR activate for writing address
//-------------------------------------------------------------------------------
			sADDR:begin
				 i2c_data_wr <= addr_reg[15: 8];
				 i2c_valid   <= 1'b1;
				 i2c_addr    <= addr_reg[6:0];
				 i2c_rnw     <=  ctrl_reg[1];
				 mm_if_busy_state   <= 1'b1;
		         cmd_rst            <= 1'b0;
				 if (ctrl_reg[6]==1'b0 && i2c_busy == 1'b1) //wait for busy to be pulled
					state <= sWAIT_DATA;
			end
//-------------------------------------------------------------------------------
//-- sWAIT_DATA
//-------------------------------------------------------------------------------
 			sWAIT_DATA: begin
				if(ctrl_reg[6] && i2c_busy == 1'b0) begin
					if(~ctrl_reg[1])begin
						if(byte_count == 'b0) 
							state <= sWAIT_STOP;
						else 
							 state <= sWRITE_DATA;
					end else
					begin
					     case (byte_count) 
						  3'b000: read_reg[ 7: 0] <=i2c_data_rd;
						  3'b001: read_reg[15: 8] <=i2c_data_rd;
						  3'b010: read_reg[23:16] <=i2c_data_rd;
						  3'b011: read_reg[31:24] <=i2c_data_rd;
						  3'b100: read_reg[39:32] <=i2c_data_rd;
						  3'b101: read_reg[47:40] <=i2c_data_rd;
						  3'b110: read_reg[55:48] <=i2c_data_rd;
						  3'b111: read_reg[63:56] <=i2c_data_rd;
						 endcase
						 //read_reg((8*byte_count)-1 downto 8*(byte_count-1)) <= i2c_data_rd;  //sample first data
						 byte_count         <= byte_count - 1'b1;
						 mm_if_busy_state   <= 1'b1;
		                 cmd_rst            <= 1'b0;
						 if(byte_count == 1'b0)  state <= sWAIT_STOP;
					end
				end
			end
//-------------------------------------------------------------------------------
//--
//-------------------------------------------------------------------------------
			  sWRITE_DATA: begin
			  		mm_if_busy_state   <= 1'b1;
		            cmd_rst            <= 1'b0;
				 case (byte_count) 
						  3'b000: i2c_data_wr <= write_reg[ 7: 0] ;
						  3'b001: i2c_data_wr <= write_reg[15: 8] ;
						  3'b010: i2c_data_wr <= write_reg[23:16] ;
						  3'b011: i2c_data_wr <= write_reg[31:24] ;
						 endcase
						 if( ctrl_reg[6] == 1'b0 && i2c_busy) begin
							state      <= sWAIT_DATA;
							byte_count <= byte_count - 1;
						 end
			  end
//-------------------------------------------------------------------------------
//--
//-------------------------------------------------------------------------------
			sWAIT_STOP: begin
				//end of transaction
				i2c_valid <= 1'b0;
				mm_if_busy_state   <= 1'b1;
		        cmd_rst            <= 1'b0;
				//wait for stop state to complete.
			 if( ctrl_reg[6] && i2c_busy == 1'b0) begin
				state <= sIDLE;
			 end
			end
			
			default: state <= sIDLE;
		endcase
	end
end
endmodule



/*
  -- Alias bits for the ctrl register
  alias cmd          : std_logic is ctrl_reg(0);  -- RW: Starts transaction on I2C bus when enabled. Automatically reset.
  alias rnw          : std_logic is ctrl_reg(1);  -- RW: Read (1) or write (0) write transaction on the I2C bus
  alias no_bytes     : std_logic_vector is ctrl_reg(4 downto 2);  --RW: Number of bytes to write or read for I2C transaction. 3 bit needed to allow for reading back 6 bytes in a row (16 bits of x,y,z accel. data)
  alias ack_error    : std_logic is ctrl_reg(5);  -- R
  alias busy         : std_logic is ctrl_reg(6);  -- R: register busy status bit from I2C master
  alias mm_if_busy : std_logic is ctrl_reg(7);  -- R: busy signal of this module's control state machine
  --alias wrapper_error : std_logic is ctrl_reg(7);
  --alias wrapper_rst   : std_logic is ctrl_reg(8);  -- RW: reset wrapper.

  signal mm_if_busy_state : std_logic;  --R: intermediate signaling of busy
  --for state machine. registered to mm_if_busy(ctrl_reg)
  signal cmd_rst            : std_logic;  --R: Clear cmd bit in ctrl_reg when command has been accepted.

  alias i2c_pointer     : std_logic_vector is addr_reg(15 downto 8);
  alias i2c_device_addr : std_logic_vector is addr_reg(6 downto 0);

*/
