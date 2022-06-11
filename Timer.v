`ifndef TIMER_V
`define TIMER_V

module Timer(
  input bit clk, reset,
  input bit set,
  input bit [15:0] newValue,
  output bit isZero
);
  
  reg [15:0] value;
  
  always @(posedge clk) begin
    
    if(reset) begin
      value <= 16'd0;
    end
    else begin
      
      if(set) begin
        value <= newValue;
      end
      else
      begin
        if (value != 0)
          value <= value - 1;
      end
      
    end
    
  end
  
  assign isZero = value == 0;
  
endmodule;

module Timer_top(
  input bit clk, reset,
  output bit isZero
);
  
  bit set = 0;
  bit [15:0] value = 16'd0;
  
  Timer timer(
    .clk(clk), .reset(reset),
    .set(set), .newValue(value),
    .isZero(isZero)
  );
  
  bit [15:0] count;
  always @(posedge clk)
  begin
    set <= 0;
    
    if (reset) begin
      value <= 0;
      count <= 0;
    end
    else
    begin
      count <= count + 1;
      
      // at count 20, set timer to 20
      // now isZero should become zero for 20 counts
      if(count == 20)
      begin
        set <= 1;
        value <= 20;
      end
    end
  end
  
endmodule;

`endif
