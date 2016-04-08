//SPI_master module for the ST MicroM25P16
`default_nettype none
module spi_master(
  input wire spimiso,
  input wire clk,
  input wire rst,
  input wire get_rdid,
  output reg spisck,
  output wire spimosi,
  output reg chip_select,
  output wire [7:0] man_id,mem_type, mem_cap
);
  //registers and wires
  reg [2:0] current_state, next_state;  //Current and Next State holders
  reg enable_get, enable_send;
  reg [2:0] send_count; //regist to hold count to send
  reg [4:0] get_count;  //register to hold count to get
  reg assert_cs;  //assert Chip Select Flag
  //wire [7:0] man_id, mem_type, mem_cap;  //mab_id, mem_type, and mem_cap outputs
  reg [23:0] read_data;

wire CLKIN_IBUFG_OUT;
wire [35:0] CONTROL0;
  //Hard Coded Maximums
  parameter [2:0] SEND_COUNT_MAX = 3'h7;
  parameter [4:0] GET_COUNT_MAX = 5'h18; 
  parameter [7:0] RDID_CODE = 8'h9F; 

  //States for our FSM
  parameter [2:0] 
    IDLE = 3'b000,
    ASSERT_CS=3'b001,
    SEND_INSTRUCTION = 3'b010,
    GET_DATA = 3'b011,
    DEASSERT_CS = 3'd100;
 

  always @ (current_state or get_rdid or spimiso) begin
  //Defaults
  next_state = IDLE;
  enable_send = 1'b0;
  enable_get = 1'b0;
  assert_cs = 1'b0;
  //Case block for defining state attributes
  case(current_state)
    //Initial IDLE state, waits for get_rdid command
    IDLE: begin
      if (get_rdid)
         next_state = ASSERT_CS;
    end
    //Asserts chip select,next state is Send_Instruction
    ASSERT_CS: begin
      next_state = SEND_INSTRUCTION;
      assert_cs = 1'b1;
    end
    //Provide counts for instructions
    SEND_INSTRUCTION: begin
      enable_send = 1'b1;
      assert_cs = 1'b1; 
      if(send_count == 0)
        next_state = GET_DATA;
      else
        next_state = SEND_INSTRUCTION;
    end
    GET_DATA: begin
      enable_get = 1'b1;
      assert_cs = 1'b1;
      if(get_count == 0)
        next_state = DEASSERT_CS;
      else
        next_state = GET_DATA;
    end
    DEASSERT_CS: begin
      next_state = IDLE;
    end
  endcase
  end

  //always block to set current_state
  always @(posedge clk or posedge rst) begin
    if(rst)
      current_state <= IDLE;
    else
      current_state <= next_state;
  end
  
  //always block to keep count of sending instruction
  always @ (posedge clk or posedge rst) begin
    if(rst)
      send_count <= SEND_COUNT_MAX;
    //Reset counter every time we're asked to get the ID again
    else if (get_rdid)
      send_count <= SEND_COUNT_MAX;
    else if (enable_send && spisck)
      send_count <= send_count - 1'b1;
  end
  //always block to keep count of getting instruction
  always @ (posedge clk or posedge rst) begin
    if(rst)
      get_count <= GET_COUNT_MAX;
    else if (get_rdid)
      get_count <= GET_COUNT_MAX;
    else if (enable_get && spisck)
      get_count <= get_count - 1'b1; 
  end
  //Need a register for the chip select
  always @(posedge clk or posedge rst) begin
    if(rst)
      chip_select <= 1'b1;
    else if (assert_cs)
      chip_select <= 1'b0;
    else
      chip_select <= 1'b1; 
  end


  //always block to collect read_data
  always @(posedge spisck or posedge rst) begin
    if(rst)
      read_data <= 24'b0;
    else 
      read_data[get_count] <= spimiso;
  end

  //Toggle spisck to avoid glitches
  always @ (posedge clk or posedge rst) begin
    if(rst)
      spisck <= 1'b0;
    else if (enable_send || enable_get)
      spisck <= !spisck;
    else if (get_rdid)
      spisck <= 1'b0;
  end
  //assign values 
  assign spimosi = RDID_CODE[send_count];
  assign man_id = read_data[23:16];
  assign mem_type = read_data[15:8];
  assign mem_cap = read_data[7:0];
  
  //synopsys_translate off
  reg [250:0] ASCII_current_state, ASCII_next_state; 
  always@* begin
    case(current_state)
      IDLE:ASCII_current_state = "IDLE";
      ASSERT_CS: ASCII_current_state = "ASSERT_CS";
      SEND_INSTRUCTION: ASCII_current_state = "SEND_INSTRUCTION";
      GET_DATA: ASCII_current_state = "GET_DATA";
      DEASSERT_CS: ASCII_current_state = "DEASSERT_CS";
    endcase
  end
  always@* begin
    case(next_state)
      IDLE:ASCII_next_state = "IDLE";
      ASSERT_CS: ASCII_next_state = "ASSERT_CS";
      SEND_INSTRUCTION: ASCII_next_state = "SEND_INSTRUCTION";
      GET_DATA: ASCII_next_state = "GET_DATA";
      DEASSERT_CS: ASCII_next_state = "DEASSERT_CS";
    endcase
  end
  //synopsys_translate on
endmodule 
