library verilog;
use verilog.vl_types.all;
entity spi_master is
    generic(
        SEND_COUNT_MAX  : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi1);
        GET_COUNT_MAX   : vl_logic_vector(4 downto 0) := (Hi1, Hi1, Hi0, Hi0, Hi0);
        RDID_CODE       : vl_logic_vector(7 downto 0) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1);
        IDLE            : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        ASSERT_CS       : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        SEND_INSTRUCTION: vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        GET_DATA        : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1);
        DEASSERT_CS     : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi0)
    );
    port(
        spimiso         : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        get_rdid        : in     vl_logic;
        spisck          : out    vl_logic;
        spimosi         : out    vl_logic;
        chip_select     : out    vl_logic;
        man_id          : out    vl_logic_vector(7 downto 0);
        mem_type        : out    vl_logic_vector(7 downto 0);
        mem_cap         : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SEND_COUNT_MAX : constant is 2;
    attribute mti_svvh_generic_type of GET_COUNT_MAX : constant is 2;
    attribute mti_svvh_generic_type of RDID_CODE : constant is 2;
    attribute mti_svvh_generic_type of IDLE : constant is 2;
    attribute mti_svvh_generic_type of ASSERT_CS : constant is 2;
    attribute mti_svvh_generic_type of SEND_INSTRUCTION : constant is 2;
    attribute mti_svvh_generic_type of GET_DATA : constant is 2;
    attribute mti_svvh_generic_type of DEASSERT_CS : constant is 2;
end spi_master;
