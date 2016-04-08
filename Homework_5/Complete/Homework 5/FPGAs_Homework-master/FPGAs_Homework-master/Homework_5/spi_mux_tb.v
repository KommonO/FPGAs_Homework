module spi_mux_tb();

  //reg inputs
  reg [7:0] mem_type, man_id, mem_cap;
  reg sw0, sw1;
  reg clk;
  //wire outputs
  wire [7:0] LED;

  spi_mux spi_mux(.mem_type(mem_type), .man_id(man_id), .mem_cap(mem_cap), .sw0(sw0), .sw1(sw1), .LED(LED));


  //run through the tests
  initial begin
    //mem_cap = 20
    sw0 = 1'b0;
    sw1 = 1'b0;
    mem_type = 8'h00000010;
    man_id   = 8'h00000015;
    mem_cap  = 8'h00000020;
    repeat(4)@(negedge clk);
    //mem_type = 10
    sw0 = 1'b1;
    repeat(4)@(negedge clk);
    //man_id = 15
    sw0 = 1'b0;
    sw1 = 1'b1;
    repeat(4)@(negedge clk);
    //FF = 8'hFF =
    sw0 = 1'b1;
    repeat(200)@(negedge clk);
    $finish;
  end

 //50 MHz clock
  initial begin
    clk = 0;
    forever clk = #50 !clk;
  end


endmodule 