`ifndef VRAM_V
`define VRAM_V

module Vram(
  input bit clk, reset, write, select, 
  input bit [BITS-1:0] address, 
  inout tri [7:0] data
);
  
  parameter BITS = 14; // default 14 bits, 16Kb (1-page)
  
  // memory storage
  reg [7:0] memory [0:(1 << BITS)-1];
  
  initial begin

    for(int i =  0; i < (1 << BITS); i++)
      memory[i] = 8'b00000000;

    memory[0] = 8'b10101010;
    memory[1] = 8'b10101010;
    memory[2] = 8'b10101010;
    memory[3] = 8'b10101010;
    memory[4] = 8'b10101010;
    memory[5] = 8'b10101010;
    memory[6] = 8'b10101010;
    memory[7] = 8'b10101010;

    memory[8] = 8'b01010101;
    memory[9] = 8'b01010101;
    memory[10] = 8'b01010101;
    memory[11] = 8'b01010101;
    memory[12] = 8'b01010101;
    memory[13] = 8'b01010101;
    memory[14] = 8'b01010101;
    memory[15] = 8'b01010101;

    memory[16] = 8'b10101010;
    memory[17] = 8'b10101010;
    memory[18] = 8'b10101010;
    memory[19] = 8'b10101010;
    memory[20] = 8'b10101010;
    memory[21] = 8'b10101010;
    memory[22] = 8'b10101010;
    memory[23] = 8'b10101010;
   

end
  
  always @(posedge clk) begin   
    if(write)
      memory[address] <= data;
  end
  
  assign data = select ? memory[address] : 8'bz;

endmodule;

`endif // VRAM_V