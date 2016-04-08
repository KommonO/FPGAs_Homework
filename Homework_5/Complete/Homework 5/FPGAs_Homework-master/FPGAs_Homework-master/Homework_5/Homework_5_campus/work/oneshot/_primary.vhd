library verilog;
use verilog.vl_types.all;
entity oneshot is
    port(
        get_rdid_debounce: in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        get_rdid_oneshot: out    vl_logic
    );
end oneshot;
