`default_nettype none
`timescale 1ns/1ns

module spi_master_tb;

  //Registers
  reg get_rdid;
  reg clk;
  reg rst;
  //wires
  wire spisck;
  wire spimiso;
  wire spimosi;
  wire chip_select;

  //Instantiating Modules in the testbench 
  spi_master spi_master(
    .spimiso(spimiso),
    .clk(clk),
    .rst(rst),
    .get_rdid(get_rdid),
    .spisck(spisck), 
    .spimosi(spimosi),
    .chip_select(chip_select));
  m25p16 m25p16(
    .c(spisck),
    .data_in(spimosi),
    .s(chip_select),
    .w(1'b1),
    .data_out(spimiso),
    .hold(1'b1));

  //run through the tests
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

  //50 MHz clock
  initial begin
    clk = 0;
    forever clk = #50 !clk;
  end
endmodule 