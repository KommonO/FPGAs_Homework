//Module created for Homework 4
module spi_master(input wire clk, rst, spimiso, input reg data, output reg spi_clk);



  //Variables that I am unsure of
  reg spisck;
  reg chip_select;  // for chip select assertion


  //synopsys translate_off



  //synopsys translate_on
  //Params for each state
  parameter 
    IDLE = 3'b000,  //IDLE State
    ASSERT_CS = 3'b001,  //ASSERT_CS state
    SEND_INSTRUCTION = 3'b010,  //SEND_INSTRUCTION State
    GET_DATA = 3'b011,  //GET_DATA State
    DEASSERT_CS = 3'b100,  //DEASSERT_CS State
    RDID_CODE = 8'h9F;  //Given in lecture 4 as RDID code

  reg [2:0] current_state, next_state;

  //Always block for FSM
  always @(current_state)
    //Initialize values that need initializing
    case(current_state)
      IDLE: begin 
        //rest goes back to here
        //!get_rdid stays in this state
       if(!get_rdid)
        next_state = IDLE; //Not necessarily needed. Used as a safeguard
       else 
        next_state = ASSERT_CS;
      end  //end IDLE case 
      
      ASSERT_CS: begin
        //Not sure what this is, maybe raise the chip select
        //and move onto Send_instruction state
        chip_select = 1'b1;
        next_state = SEND_INSTRUCTION;
      end  //end ASSERT_CS
      
      SEND_INSTRUCTION: begin
        //*********  Not Entirely sure what this state does
        enable_send = 1'b1;
        next_state = GET_DATA;
      end  //end SEND_INSTRUCTION
      
      GET_DATA: begin
        data_received = 1'b1
        next_state = DEASSERT_CS;
      end
      DEASSERT_CS: begin
        next_state = IDLE;
      end //End DEASSERT_CS 
    endcase
  end



  //always block to assign state
  always  @(posedge clk or negedge rst) begin
    if(rst)
      current_state <= IDLE;
    else
      current_state <= next_state;
  end//end always block for state

//ASCII BLOCKS
  reg[95:0] ASCII_current_state;
  reg[95:0] ASCII_next_state;

  always @(current_state) begin
    case(current_state)
      IDLE: ASCII_current_state = "IDLE";
      ASSERT_CS: ASCII_current_state = "ASSERT_CS";
      SEND_INSTRUCTION: ASCII_current_state = "SEND_INSTRUCTION";
      GET_DATA: ASCII_current_state = "GET_DATA";
      DEASSERT_CS: ASCII_current_state = "DEASSERT_CS";
    endcase
  end
  always @(next_state) begin
    case(next_state)
      IDLE: ASCII_next_state = "IDLE";
      ASSERT_CS: ASCII_next_state = "ASSERT_CS";
      SEND_INSTRUCTION: ASCII_next_state = "SEND_INSTRUCTION";
      GET_DATA: ASCII_next_state = "GET_DATA";
      DEASSERT_CS: ASCII_next_state = "DEASSERT_CS";
    endcase
  end


endmodule 