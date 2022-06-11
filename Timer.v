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
  input bit clk, reset
);

endmodule;

`endif
