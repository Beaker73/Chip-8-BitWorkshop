module Clock(
  input bit clk, reset, vSync,
  output bit timerClk, instrClk
);
  
  // clk = 4.857.480 Hz
  // every 80958 ticks = 60hz  (timers)
  // every  9714 ticks = 500hz (instruction)
  parameter INSTR_TICK = 9714;
  parameter TIMER_TICK = 80958;

  //reg [16:0] timerTick;
  reg [13:0] instrTick;
  
  always @(posedge clk)
  begin
    if(reset) begin
      //timerTick <= 17'd0;
      //timerClk <= 0;
      instrTick <= 14'd0;
      instrClk <= 0;
    end
    else begin
      
      //if(timerTick == TIMER_TICK) begin
        //timerClk <= 1;
        //timerTick <= 0;
      //end else begin
        //timerClk <= 0;
      	//timerTick <= timerTick + 1;
      //end
      
      if(instrTick == INSTR_TICK) begin
        instrClk <= 1;
        instrTick <= 0;
      end else begin
        instrClk <= 0;
        instrTick <= instrTick + 1;
      end
      
    end
  end
  
  // let timer clk match the vSync we have now
  assign timerClk = vSync;
  
endmodule;