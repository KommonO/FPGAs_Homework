//Module to debounce the circuit for the  FPGA board
//`timescale 1ns/100ps
module debounce(input wire clk,rst, get_rdid, output reg get_rdid_debounce);
  reg q_1;
  reg [31:0] count;
  
  wire count_MAX = &count;

always @ (posedge clk or posedge rst) begin
  if(rst)
    q_1 <= 1'b0;
  else
    q_1 <= get_rdid;
end
always @ (posedge clk or posedge rst) begin
  if(rst) begin
    get_rdid_debounce <= 1'b0;
    count <= 1'b0;
  end
  else begin
    count <= count + 1'b1;
    if(count_MAX) begin
      get_rdid_debounce <= q_1;
      count <= 1'b0;
    end
  end
end




endmodule 
