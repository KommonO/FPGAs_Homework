//Module to debounce the circuit for the  FPGA board
//`timescale 1ns/100ps
module debounce(input wire clk,rst, async_in, output reg sync_out);
  reg q_1;
  //15 bit register
  reg [14:0] count;
  //count_MAX is equal to the value where the binary version of
  //count is all 1s
  wire count_MAX = &count;
//always block needed for async_in
always @ (posedge clk or posedge rst) begin
  if(rst)
    q_1 <= 1'b0;
  else
    q_1 <= async_in;
end

//always block needed for sync_out
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

