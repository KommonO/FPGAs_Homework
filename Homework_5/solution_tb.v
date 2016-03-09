`default_nettype none
`timescale 1ns/1ns

module rdid_tb;

reg clk;
reg rst;
reg get_rdid;

wire spimiso;
wire spisck;
wire spimosi;
wire prom_cs_n;

initial begin
  rst = 1'b0;
  rst = 1'b1;
  get_rdid = 1'b0;
  repeat(2)@(negedge clk);
  rst = 1'b0;
  repeat(4)@(negedge clk);
  get_rdid = 1'b1;
  repeat(1)@(negedge clk);
  get_rdid=1'b0;
  repeat(200)@(negedge clk);
  $finish;
  end
  
  initial begin
    clk = 0;
    forever clk = #50 !clk;
  end
  
  rdid rdid(
    .spimiso(spimiso),
    .clk(clk),
    .rst(rst),
    .get_rdid(get_rdid),
    .spisck(spisck), 
    .spimosi(spimosi),
    .prom_cs_n(prom_cs_n));
  m25p16 m25p16(
    .c(spisck),
    .data_in(spimosi),
    .s(prom_cs_n),
    .w(1'b1),
    .data_out(spimiso),
    .hold(1'b1)
);


 
endmodule 