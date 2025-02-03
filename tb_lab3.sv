module tb_lab3();
  reg clk, rst_n, err;
  reg [9:0]
  reg [3:0] correct_number;
  reg [2:0] present_state, next_state; 
  reg open, closed, correct;
  
  lab3_top dut(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);

  initial begin
    clk = 0; #5;
    forever begin
      clk = 1; #5; 
      clk = 0; #5; 
    end
  end 
  initial begin //all initial blocks function in parallel, starting at time t = 0
    rst_n = 1; err = 0; //err will change to 1 at the exact time where the error occurs
    #10; 
    if (tb_lab3.dut.present_state !== `S0) begin//corner case issues so need two equals signs 
      $display("Error ** state is %b, expected %b", tb_lab3.dut.present_state, `S0);
      err = 1'b1;
    end
    if (tb_lab3.dut.open !== 1'b0) begin
      $display("Error ** open is %b, expected %b", tb_lab3.dut.open, 1'b0);
      err = 1'b1;
    end
    if (tb_lab3.dut.closed !== 1'b0) begin
      $display("Error ** closed is %b, expected %b", tb_lab3.dut.closed, 1'b0);
      err = 1'b1;
    end
    if (tb_lab3.dut.correct !== 1'b1) begin
      $display("Error ** correct is %b, expected %b", tb_lab3.dut.correct, 1'b1);
      err = 1'b1;
    end
    rst_n = 0; 
    #10; 
    SW = `B_6;
    #10
    if (tb_lab3.dut.present_state !== `S1) begin 
      $display("Error ** state is %b, expected %b", tb_lab3.dut.present_state, `S1);
      err = 1'b1;
    end
    if (tb_lab3.dut.correct_number !== `B_6) begin 
      $display("Error ** currect_number is %b, expected %b", tb_lab3.dut.correct_number, `B_6);
      err = 1'b1;
    end 
    SW = `B_2;
    #10
    if (tb_lab3.dut.present_state !== `S2) begin 
      $display("Error ** state is %b, expected %b", tb_lab3.dut.present_state, `S2);
      err = 1'b1;
    end
    if (tb_lab3.dut.correct_number !== `B_2) begin 
      $display("Error ** currect_number is %b, expected %b", tb_lab3.dut.correct_number, `B_2);
      err = 1'b1;
    end 
    SW = `B_3;
    #10
    if (ptb_lab3.dut.present_state !== `S3) begin 
      $display("Error ** state is %b, expected %b", tb_lab3.dut.present_state, `S3);
      err = 1'b1;
    end
    if (tb_lab3.dut.correct_number !== `B_3) begin 
      $display("Error ** currect_number is %b, expected %b", tb_lab3.dut.correct_number, `B_3);
      err = 1'b1;
    end
    SW = `B_9;
    #10
    if (tb_lab3.dut.present_state !== `S4) begin 
      $display("Error ** state is %b, expected %b", tb_lab3.dut.present_state, `S4);
      err = 1'b1;
    end
    if (tb_lab3.dut.correct_number !== `B_9) begin 
      $display("Error ** currect_number is %b, expected %b", tb_lab3.dut.correct_number, `B_9);
      err = 1'b1;
    end 
    SW = `B_4;
    #10
    if (tb_lab3.dut.present_state !== `S5) begin 
      $display("Error ** state is %b, expected %b", tb_lab3.dut.present_state, `S5);
      err = 1'b1;
    end
    if (tb_lab3.dut.correct_number !== `B_4) begin 
      $display("Error ** currect_number is %b, expected %b", tb_lab3.dut.correct_number, `B_4);
      err = 1'b1;
    end 
    SW = `B_2;
    #10
    if (tb_lab3.dut.present_state !== `S6) begin 
      $display("Error ** state is %b, expected %b", tb_lab3.dut.present_state, `S6);
      err = 1'b1;
    end
    if (tb_lab3.dut.correct_number !== `B_2) begin 
      $display("Error ** currect_number is %b, expected %b", tb_lab3.dut.correct_number, `B_2);
      err = 1'b1;
    end 
    #10; 
    
    if (tb_lab3.dut.present_state !== `S0) begin//corner case issues so need two equals signs 
      $display("Error ** state is %b, expected %b", tb_lab3.dut.present_state, `S0);
      err = 1'b1;
    end
    if (tb_lab3.dut.open !== 1'b1) begin
      $display("Error ** open is %b, expected %b", tb_lab3.dut.open, 1'b1);
      err = 1'b1;
    end
    if (tb_lab3.dut.closed !== 1'b0) begin
      $display("Error ** closed is %b, expected %b", tb_lab3.dut.closed, 1'b0);
      err = 1'b1;
    end
    if (tb_lab3.dut.correct !== 1'b1) begin
      $display("Error ** correct is %b, expected %b", tb_lab3.dut.correct, 1'b1);
      err = 1'b1;
    end
    if (~err) $display("Passed");
    $stop;
  end 
endmodule: tb_lab3
