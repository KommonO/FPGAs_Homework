//Module for the one shot 
module oneshot(input get_rdid_debounce, clk, rst, output wire get_rdid_oneshot);
reg get_rdid_debounce_q;
//D-FF
always @ (posedge clk) begin
  if (rst)
    get_rdid_debounce_q <= 0;
  else
    get_rdid_debounce_q <= get_rdid_debounce;
  
end
//Logic in lecture slides
assign get_rdid_oneshot = ~get_rdid_debounce_q && get_rdid_debounce;
endmodule

