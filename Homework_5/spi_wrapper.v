//Wrapper module to tie in all necessary modules
//According to the diagram, there are at LEAST 3 inputs
//BTN1, BTN0, and CCLK
//CCLK is the onboard crystal clock
//We may have to have additional I/O for the multiplexer seen in the diagram
//Looks like switch 0 and switch 1 will have to be the switches on the board
module spi_wrapper(input BTN1, BTN0, CCLK, output reg [7:0] LED);

//instantiate spi_master
spi_master spi_master();

//instantiate clock divider


//instantiate debouncer
debounce debounce();

//instantiate oneshot
oneshot oneshot();
endmodule 