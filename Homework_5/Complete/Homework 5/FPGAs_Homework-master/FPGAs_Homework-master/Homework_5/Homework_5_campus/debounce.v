//Module to debounce the circuit for the  FPGA board
//`timescale 1ns/100ps
module debounce(input wire clk,rst, async_in, output reg sync_out);
  reg q_1;
  //15 bit counter
  reg [14:0] count;
  //Count_MAX will be high when count is at the max bit value
  //& sign ands the count bits together
  wire count_MAX = &count;
//always block for the async_in
always @ (posedge clk or posedge rst) begin
  if(rst)
    q_1 <= 1'b0;
  else
    q_1 <= async_in;
end
//always block for the sync_out
always @ (posedge clk or posedge rst) begin
  if(rst) begin
    sync_out <= 1'b0;
    count <= 1'b0;
  end
  else begin
    count <= count + 1'b1;
    if(count_MAX) begin
      sync_out <= q_1;
      count <= 1'b0;
    end
  end
end

endmodule 

