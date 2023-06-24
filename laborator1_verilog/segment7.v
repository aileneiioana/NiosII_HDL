module segment7(
     input [3:0] bcd,
     output [7:0] seg
    );
     
     //Declare inputs,outputs and internal variables.
   //  input [3:0] bcd;
   //  output [6:0] seg;
     reg [7:0] segment;
	  
	  assign seg = segment;

//always block for converting bcd digit into 7 segment format
    always @(bcd)
    begin
        case (bcd) //case statement
            0 : segment = 8'b11000000;
            1 : segment = 8'b11111001;
            2 : segment = 8'b10100100;
            3 : segment = 8'b10110000;
            4 : segment = 8'b10011001;
            5 : segment = 8'b10010010;
            6 : segment = 8'b10000010;
            7 : segment = 8'b11111000;
            8 : segment = 8'b10000000;
            9 : segment = 8'b10011000;
				10: segment = 8'b10111111; //minus
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : segment = 8'b11111111; 
        endcase
    end
    
endmodule