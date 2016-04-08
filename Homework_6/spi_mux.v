//Need to create a module for the mux seen in the bottom of the spi wrapper class
module spi_mux(input wire [7:0] mem_cap, mem_type, man_id, input sw0, sw1, output reg [7:0] LED);

//Parameter for the case if switches = 11
parameter FF_IN = 8'hFF;
parameter 
  MEM_CAP  = 2'b00,
  MEM_TYPE = 2'b01,
  MAN_ID   = 2'b10,
  FF       = 2'b11;
  wire [1:0] switches; //not sure if this needs to stay as wire or needs to be reg
  assign switches[1] = sw1;
  assign switches[0] = sw0;
 
always @* begin
  //defaults for the mux, not sure if there should be any
  case (switches)
    MEM_CAP: LED <= mem_cap;
    MEM_TYPE: LED <= mem_type;
    MAN_ID: LED <= man_id; 
    FF: LED <= FF_IN;
  endcase  //End of case statement for each state of the switches
end  //end always @*


endmodule

