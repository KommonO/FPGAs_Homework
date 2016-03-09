//Module for the one shot 
//This may need to use the spiclk but not sure
module oneshot(input get_rdid_debounce, clk, rst, output wire get_rdid_oneshot);
reg get_rdid_debounce_q;
always @ (posedge clk) begin
  if (rst)
    get_rdid_debounce_q <= 0;
  else
    get_rdid_debounce_q <= get_rdid_debounce;
  
end
assign get_rdid_oneshot = ~get_rdid_debounce_q && get_rdid_debounce;



endmodule
