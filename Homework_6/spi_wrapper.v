//Wrapper module to tie in all necessary modules
//CCLK is the onboard crystal clock
//Looks like switch 0 and switch 1 will have to be the switches on the board

//just connects wires to each module
module spi_wrapper(input BTN1, BTN0, CCLK,SPIMISO, SW0,SW1,
 output wire LED0, LED1,LED2,LED3,LED4,LED5,LED6,LED7,
 SPIMOSI, SPISCK, FPGAIB, DACCS, ADCON, SFCE, AMPCS, SPICS);

//Define our wires
wire [7:0] LED;
wire [35:0] CONTROL0;
wire CLKIN_IBUFG_OUT;
wire CONTROL;
wire rst, get_rdid;
wire clk;
wire [7:0] man_id, mem_cap, mem_type;
wire get_rdid_oneshot;
//These bit assignments are required
assign DACCS = 1'b1;
assign ADCON = 1'b0;
assign FPGAIB = 1'b1;
assign AMPCS = 1'b1;
assign SFCE = 1'b1;

//assign all LEDs
assign LED7 = LED[7];
assign LED6 = LED[6];
assign LED5 = LED[5];
assign LED4 = LED[4];
assign LED3 = LED[3];
assign LED2 = LED[2];
assign LED1 = LED[1];
assign LED0 = LED[0];


// Instantiate the clock divider module
clock_divider instance_name (
    .CLKIN_IN(CCLK), 
    .CLKDV_OUT(clk), 
    .CLKIN_IBUFG_OUT(CLKIN_IBUFG_OUT), 
    .CLK0_OUT(), 
    .LOCKED_OUT()
    );
//ICON
icon icon(
    .CONTROL0(CONTROL0) // INOUT BUS [35:0]
);

//ILA
ila ila (
    .CONTROL(CONTROL0), // INOUT BUS [35:0]
    .CLK(CLKIN_IBUFG_OUT), // IN
	 .TRIG0({mem_cap[0], mem_cap[1], mem_cap[2], SPICS, SPIMOSI, SPIMISO, SPISCK, get_rdid_oneshot}) // IN BUS [7:0]
);

//instantiate spi_master
spi_master spi_master(.spimiso(SPIMISO), .spimosi(SPIMOSI), .clk(clk), .rst(rst),
 .get_rdid(get_rdid_oneshot), .spisck(SPISCK), .chip_select(SPICS),.man_id(man_id),
 .mem_type(mem_type), .mem_cap(mem_cap));
//instantiate debouncer for reset
debounce debounce_rst(.clk(clk), .rst(1'b0),.async_in(BTN0), .sync_out(rst));
//debounce for get_rdid signal
debounce debounce(.clk(clk),.rst(1'b0),.async_in(BTN1),.sync_out(get_rdid));
//instantiate oneshot
oneshot oneshot(.get_rdid_debounce(get_rdid), .rst(rst), .clk(clk), .get_rdid_oneshot(get_rdid_oneshot));
//Instantiate the multiplexer
spi_mux spi_mux(.mem_cap(mem_cap), .man_id(man_id), .mem_type(mem_type), .sw0(SW0), .sw1(SW1), .LED(LED));
endmodule 
