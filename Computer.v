`include "Clock.v"
`include "Timer.v"
`include "Ram.v"
`include "Vram.v"
`include "SyncGenerator.v"
`include "Vdp.v"

const bit [3:0] STATE_SLEEP = 4'h0;
const bit [3:0] STATE_GETINSTR0 = 4'h1;
const bit [3:0] STATE_GETINSTR1 = 4'h2;
const bit [3:0] STATE_FINISH_READ = 4'h3;
const bit [3:0] STATE_EXECUTE = 4'h4;
const bit [3:0] STATE_CMD_D_Y = 4'h5;
const bit [3:0] STATE_CMD_D_D = 4'h6;
const bit [3:0] STATE_CMD_D_HIT = 4'h7;


module top(
  input bit clk, reset,
  output bit hsync, vsync,
  output bit [2:0] rgb,
  output bit spkr
);
  
  wire bit timerClk, instrClk;
  Clock clock(
    .clk(clk), .reset(reset),
    .vSync(vsync),
    .timerClk(timerClk), 
    .instrClk(instrClk)
  );
  
  wire bit isDelayTimerZero;
  Timer delayTimer(
    .clk(timerClk), 
    .reset(reset),
    .set(0),
    .newValue(0),
    .isZero(isDelayTimerZero)
  );

  bit soundWave;
  always @(posedge instrClk) begin
    soundWave <= !soundWave;
  end

  bit isSoundTimerZero;
  Timer soundTimer(
    .clk(timerClk), 
    .reset(reset),
    .set(0),
    .newValue(0),
    .isZero(isSoundTimerZero)
  );
  
  assign spkr = isSoundTimerZero ? 0 : soundWave;
  
  // tri [7:0] data;
  bit enableRam;
  bit [11:0] address;
  Ram #(.BITS(12)) ram(
    .clk(clk), .reset(reset), 
    .write(0), 
    .select(enableRam), 
    .address(address),
    .data(data)
  );

  bit [2:0] vdpCmd = VDP_CMD_NONE;
  wire [7:0] vdpData;
  bit vdpHit;
  Vdp vdp(
    .clk(clk), .reset(reset),
    .cmd(vdpCmd), .cmdData(vdpData),
    .hSync(hsync), .vSync(vsync), .spriteHit(vdpHit),
    .rgb(rgb)
  );

  reg [11:0] pc;
  reg [11:0] ix;
  reg [7:0] v[16];
  reg [7:0] stack[64];
  reg [7:0] sp;
  
  reg [3:0] state;
  reg [15:0] instr;
  reg [3:0] remain;
  
  tri [7:0] data;

  always @(posedge clk) begin
    
    vdpCmd <= VDP_CMD_NONE;
    
    if (reset) begin
      pc <= 12'h200;
      state <= STATE_SLEEP;
    end else if(instrClk) begin
      state <= STATE_GETINSTR0;
    end else begin
      case(state)

        STATE_GETINSTR0: begin
          address <= pc[11:0];
          enableRam <= 1;
          pc <= pc + 1;
          state <= STATE_GETINSTR1;
        end

        STATE_GETINSTR1: begin
          instr[15:8] <= data;
          address <= pc[11:0];
          enableRam <= 1;
          pc <= pc + 1;
          state <= STATE_FINISH_READ;
        end
        
        STATE_FINISH_READ: begin
          enableRam <= 0;
          instr[7:0] <= data;
          state <= STATE_EXECUTE;
        end
        
        STATE_EXECUTE: begin
          
          case(instr[15:12])
            
            // 1nnn - JP addr
            4'h1: begin
              pc <= instr[11:0];
            end
            
            // 6xkk - LD Vx, byte
            4'h6: begin
              v[instr[11:8]] <= instr[7:0];
            end
            
            // Annn - LD I, addr
            4'ha: begin
              ix <= instr[11:0];
            end
            
            // Dxyn - DRW Vx, Vy, nibble
            // Display n-byte sprite starting at memory location I at (Vx,Vy), set VF = collision
            // The interpreter reads n bytes from memory, starting at the address stored in I. 
            // These bytes are then displayed as sprites on screen at coordinates (Vx, Vy). 
            // Sprites are XORed onto the existing screen. 
            // If this causes any pixels to be erased, VF is set to 1, otherwise it is set to 0. 
            // If the sprite is positioned so part of it is outside the coordinates of the display, 
            // it wraps around to the opposite side of the screen.
            4'hd: begin
              // start with sending x position to VDP
              vdpCmd <= VDP_CMD_SETX;
              vdpData <= v[instr[11:8]];
              // next cycle send y position to VDP
              state <= STATE_CMD_D_Y;
              // and setup register that knows how much is left to send to vdp
              remain <= instr[3:0];
            end
            
            default: begin end
          endcase
          
          state <= STATE_SLEEP;
        end
        
        STATE_CMD_D_Y: begin
          // 2nd step for Dxyn command
          // send y position to VDP
          vdpCmd <= VDP_CMD_SETY;
          vdpData <= v[instr[7:4]];
          // start retrieving sprite bytes for next steps
          enableRam <= 1;
          address <= ix;
          ix <= ix + 1;
        end
        
        STATE_CMD_D_D: begin
          // 3th-nth steps for Dxyn commnad
          // send data byte of sprite to VDP
          vdpCmd <= VDP_CMD_XOR_BYTE;
          vdpData <= data;
          remain <= remain - 1;
          if( remain == 1 )
          	state <= STATE_CMD_D_HIT;
	  else
          begin
            // start retrieving next byte to send
            // from memory
            enableRam <= 1;
            address <= ix;
            ix <= ix + 1;
            // no state change, we re-execute this stage
          end
        end
        
        STATE_CMD_D_HIT: begin
          // final step for Dxyn command
          // get the hit state from vdp
          v[4'hf] <= { 7'd0, vdpHit };
          state <= STATE_SLEEP;
        end
        
        default: begin 
          enableRam <= 0;
        end

      endcase
    end
  end


endmodule // top

