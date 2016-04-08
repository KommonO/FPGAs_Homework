library verilog;
use verilog.vl_types.all;
entity spi_wrapper is
    port(
        BTN1            : in     vl_logic;
        BTN0            : in     vl_logic;
        CCLK            : in     vl_logic;
        SPIMISO         : in     vl_logic;
        SW0             : in     vl_logic;
        SW1             : in     vl_logic;
        LED0            : out    vl_logic;
        LED1            : out    vl_logic;
        LED2            : out    vl_logic;
        LED3            : out    vl_logic;
        LED4            : out    vl_logic;
        LED5            : out    vl_logic;
        LED6            : out    vl_logic;
        LED7            : out    vl_logic;
        SPIMOSI         : out    vl_logic;
        SPISCK          : out    vl_logic;
        FPGAIB          : out    vl_logic;
        DACCS           : out    vl_logic;
        ADCON           : out    vl_logic;
        SFCE            : out    vl_logic;
        AMPCS           : out    vl_logic;
        SPICS           : out    vl_logic
    );
end spi_wrapper;
