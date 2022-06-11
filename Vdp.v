`ifndef VDP_V
`define VDP_V

`include "Vram.v"
`include "SyncGenerator.v"

const bit [2:0] VDP_CMD_NONE = 3'b000;
const bit [2:0] VDP_CMD_SETX = 3'b001;
const bit [2:0] VDP_CMD_SETY = 3'b010;
const bit [2:0] VDP_CMD_XOR_BYTE = 3'b011;

module Vdp(
  input bit clk, reset,
  input bit [2:0] cmd,
  input bit [7:0] cmdData,
  output bit hSync, vSync, spriteHit,
  output bit [2:0] rgb
);
  
  wire bit isActive;
  wire [8:0] xPos, yPos;
  SyncGenerator sync(
    .clk(clk), .reset(reset),
    .hShift(4'd8), .vShift(4'd15),
    .hSync(hSync), .vSync(vSync), .isActive(isActive),
    .xPos(xPos), .yPos(yPos)
  );
  
  // 64 bits x 32rows (64/8*32 = 256 bytes = 8bits wide)
  // h: 256/64 = 4 bits per pixel
  bit [7:0] address;
  tri [7:0] data;
  Vram #(.BITS(8)) vram(
    .clk(clk), .reset(reset),
    .write(0), .select(enableRam),
    .address(address), .data(data)
  );
  
  bit [7:0] spriteX, spriteY;
  
  bit enableRam = 0;
  bit [7:0] buffer;
  bit white;

  // adjust x by time to get data
  bit [8:0] x;
  assign x = xPos - 2;
  
  always @(posedge clk) begin
    enableRam <= 0;
    
    if(isActive) begin
      // read byte every 32 pixels (8x4)
      if(xPos[4:0] == 0) begin
        address <= { yPos[6:2], xPos[7:5] };
        enableRam <= 1;
      end
      if(xPos[4:0] == 1) begin
        buffer <= data;
      end
    end
    
    white <= yPos < (32*4) && x[8] == 0 ? buffer[x[4:2]] : 0;
  end
  
  assign rgb = white ? 3'b111 : 3'b000;
  assign spriteHit = 0;
  
endmodule;

`endif