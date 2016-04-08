library verilog;
use verilog.vl_types.all;
entity debounce is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        async_in        : in     vl_logic;
        sync_out        : out    vl_logic
    );
end debounce;
