module lab3_top(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
  input [9:0] SW; //only using SW(1-4)
  input [3:0] KEY; 
  output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  output [9:0] LEDR;   //optional: use these outputs for debugging on your DE1-SoC

  wire clk = ~KEY[0];  //this is your clock
  wire rst_n = KEY[3]; //this is your reset; your reset should be synchronous and active-low
  reg [2:0] present_state; 
  reg correct; //stays high only if all 6 numbers are correct
  
  //define decimal outputs for seven-segment display
  `define D_0 7'b1000000
  `define D_1 7'b1111001
  `define D_2 7'b0100100
  `define D_3 7'b0110000
  `define D_4 7'b0011001
  `define D_5 7'b0010010
  `define D_6 7'b0000010
  `define D_7 7'b1111000
  `define D_8 7'b0000000
  `define D_9 7'b0010000

  //define binary inputs for seven-segment display
  `define B_0 4'b0000
  `define B_1 4'b0001
  `define B_2 4'b0010
  `define B_3 4'b0011
  `define B_4 4'b0100
  `define B_5 4'b0101
  `define B_6 4'b0110
  `define B_7 4'b0111
  `define B_8 4'b1000
  `define B_9 4'b1001
  `define B_10 4'b1010
  `define B_11 4'b1011
  `define B_12 4'b1100
  `define B_13 4'b1101
  `define B_14 4'b1110
  `define B_15 4'b1111

  //define letter outputs for seven-segment display 
  `define E 7'b0000110    
  `define r 7'b1001110
  `define O 7'b1000000
  `define P 7'b0001100
  `define n 7'b1001000
  `define C 7'b1000110
  `define L 7'b1000111
  `define S 7'b0010010
  `define d 7'b0100001
  `define off 7'b1111111

  //define states
  `define S0 3'b000
  `define S1 3'b001
  `define S2 3'b010
  `define S3 3'b011
  `define S4 3'b100
  `define S5 3'b101
  `define S6 3'b110
  
  //when clk (KEY[0]) pressed, changes states
  always_ff @(posedge clk) begin 
    if (rst_n) begin //reset configuration if the reset button is pressed on posedge clk
      correct <= 1'b1;
      present_state <= `S0;
    end 
    else begin
      //present_state <= next_state;
      case (present_state)
        `S0: begin
              present_state <= `S1;
              if (SW[3:0] !== `B_6) 
                correct = 1'b0;
             end
        `S1: begin
              present_state <= `S2;
              if (SW[3:0] !== `B_2) 
                correct = 1'b0;
             end 
        `S2: begin
              present_state <= `S3;
               if (SW[3:0] !== `B_3) 
                 correct = 1'b0;
             end
        `S3: begin 
              present_state <= `S4;
              if (SW[3:0] !== `B_9) 
                correct = 1'b0;
             end 
        `S4: begin 
              present_state <= `S5;
              if (SW[3:0] !== `B_4) 
                correct = 1'b0;
             end 
        `S5: begin 
              present_state <= `S6;
              if (SW[3:0] !== `B_2) 
                correct = 1'b0;
             end 
        `S6: present_state <= `S6;
        default: begin 
          if (SW[3:0] == 4'bxxxx) 
                correct = 1'b0;
             end 
      endcase 
      //if the current switch combination matches the number, the combination is correct (so far) 
      //if an incorrect number is entered, the combination is now incorrect
    end 
  end
  //always display the current combination of the switches, unless the lock is open or closed 
  always_comb begin
    case (present_state)
      `S6: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = correct ? {`off, `off, `O, `P, `E, `n} : {`C, `L, `O, `S, `E, `d};
      default: case (SW[3:0]) //display current combination of switches on HEX0 or 'ErrOr' on HEX4-HEX0 if not in range 0-9
        `B_0: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_0};
        `B_1: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_1};
        `B_2: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_2};
        `B_3: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_3};
        `B_4: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_4};
        `B_5: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_5};
        `B_6: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_6};
        `B_7: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_7};
        `B_8: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_8};
        `B_9: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `off, `off, `off, `off, `D_9};
        `B_10: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `E, `r, `r, `O, `r};
        `B_11: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `E, `r, `r, `O, `r};
        `B_12: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `E, `r, `r, `O, `r};
        `B_13: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `E, `r, `r, `O, `r};
        `B_14: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `E, `r, `r, `O, `r};
        `B_15: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {`off, `E, `r, `r, `O, `r};
        default: {HEX5, HEX4, HEX3, HEX2, HEX1, HEX0} = {7'bxxxxxxx, 7'bxxxxxxx, 7'bxxxxxxx, 7'bxxxxxxx, 7'bxxxxxxx, 7'bxxxxxxx};
      endcase 
    endcase 
   end
endmodule
