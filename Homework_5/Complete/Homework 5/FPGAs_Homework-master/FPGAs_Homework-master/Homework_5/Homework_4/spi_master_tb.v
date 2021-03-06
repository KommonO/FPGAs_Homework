//Additional File created to test my spi_master.v
//We are specifically testing the rdid command
`default_nettype none
`timescale 1ns/1ns

module spi_master_tb;

  //inputs to the spi_master
  reg clk, rst, get_rdid;

  //SPI wires
  wire spisck;  //clock
  wire chip_select;  //Chip select
  wire spimiso;  //read
  wire spimosi;  //write



//Instantiate modules

spi_master spi_master( 
  .clk(clk),
  .rst(rst), 
  .get_rdid(get_rdid), 
  .spimiso(spimiso), 
  .spimosi(spimosi), 
  .spisck(spisck),
  .chip_select(chip_select));

m25p16 m25p16(
  .c(spisck),
  .s(chip_select),
  .w(1'b1),
  .hold(1'b1),
  .data_in(spimosi),
  .data_out(spimiso));

//Input Testing
initial begin
  rst = 1'b0;
  rst = 1'b1; 
  
  get_rdid = 1'b0;
  repeat(2) @ (negedge clk);
  rst = 1'b0;
  repeat(4) @ (negedge clk);
  get_rdid = 1'b1;
  repeat(1) @ (negedge clk);
  get_rdid = 1'b0; 
  repeat(200) @ (negedge clk);
  get_rdid = 1'b1;
  repeat(1)@(negedge clk);
  get_rdid = 1'b0; 
  repeat (200) @ (negedge clk);

  $finish;
end  
  

//50MHz Clock
initial begin
  clk = 0;
  forever clk = #50 ~clk;
end

endmodule
