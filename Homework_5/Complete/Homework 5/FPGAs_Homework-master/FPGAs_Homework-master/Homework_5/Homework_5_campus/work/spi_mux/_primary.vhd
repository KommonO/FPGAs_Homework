library verilog;
use verilog.vl_types.all;
entity spi_mux is
    generic(
        FF_IN           : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        \MEM_CAP\       : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        \MEM_TYPE\      : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        \MAN_ID\        : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        FF              : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        mem_cap         : in     vl_logic_vector(7 downto 0);
        mem_type        : in     vl_logic_vector(7 downto 0);
        man_id          : in     vl_logic_vector(7 downto 0);
        sw0             : in     vl_logic;
        sw1             : in     vl_logic;
        LED             : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of FF_IN : constant is 1;
    attribute mti_svvh_generic_type of \MEM_CAP\ : constant is 1;
    attribute mti_svvh_generic_type of \MEM_TYPE\ : constant is 1;
    attribute mti_svvh_generic_type of \MAN_ID\ : constant is 1;
    attribute mti_svvh_generic_type of FF : constant is 1;
end spi_mux;
