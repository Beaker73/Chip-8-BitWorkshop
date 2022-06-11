`ifndef RAM_V
`define RAM_V

module Ram(
  input bit clk, reset, write, select, 
  input bit [BITS-1:0] address, 
  inout tri [7:0] data
);
  
  parameter BITS = 14; // default 14 bits, 16Kb (1-page)
  
  // memory storage
  reg [7:0] memory [0:(1 << BITS)-1];
  
  // data
  `ifdef INIT
  initial begin
    
    if(BITS == 12)
    begin
      // 0
      memory[0] = 8'hf0;
      memory[1] = 8'h90;
      memory[2] = 8'h90;
      memory[3] = 8'h90;
      memory[4] = 8'hf0;
      // 1
      memory[5] = 8'h20;
      memory[6] = 8'h60;
      memory[7] = 8'h20;
      memory[8] = 8'h20;
      memory[9] = 8'h70;

      // program @ 0x200 (test_opcode.ch8)
      memory[12'h200] = 8'h12;
      memory[12'h201] = 8'h4E;
      memory[12'h202] = 8'hEA;
      memory[12'h203] = 8'hAC;
      memory[12'h204] = 8'hAA;
      memory[12'h205] = 8'hEA;
      memory[12'h206] = 8'hCE;
      memory[12'h207] = 8'hAA;
      memory[12'h208] = 8'hAA;
      memory[12'h209] = 8'hAE;
      memory[12'h20a] = 8'hE0;
      memory[12'h20b] = 8'hA0;
      memory[12'h20c] = 8'hA0;
      memory[12'h20d] = 8'hE0;
      memory[12'h20e] = 8'hC0;
      memory[12'h20f] = 8'h40;
      memory[12'h210] = 8'h40;
      memory[12'h211] = 8'hE0;
      memory[12'h212] = 8'hE0;
      memory[12'h213] = 8'h20;
      memory[12'h214] = 8'hC0;
      memory[12'h215] = 8'hE0;
      memory[12'h216] = 8'hE0;
      memory[12'h217] = 8'h60;
      memory[12'h218] = 8'h20;
      memory[12'h219] = 8'hE0;
      memory[12'h21a] = 8'hA0;
      memory[12'h21b] = 8'hE0;
      memory[12'h21c] = 8'h20;
      memory[12'h21d] = 8'h20;
      memory[12'h21e] = 8'h60;
      memory[12'h21f] = 8'h40;
      memory[12'h220] = 8'h20;
      memory[12'h221] = 8'h40;
      memory[12'h222] = 8'hE0;
      memory[12'h223] = 8'h80;
      memory[12'h224] = 8'hE0;
      memory[12'h225] = 8'hE0;
      memory[12'h226] = 8'hE0;
      memory[12'h227] = 8'h20;
      memory[12'h228] = 8'h20;
      memory[12'h229] = 8'h20;
      memory[12'h22a] = 8'hE0;
      memory[12'h22b] = 8'hE0;
      memory[12'h22c] = 8'hA0;
      memory[12'h22d] = 8'hE0;
      memory[12'h22e] = 8'hE0;
      memory[12'h22f] = 8'hE0;
      memory[12'h230] = 8'h20;
      memory[12'h231] = 8'hE0;
      memory[12'h232] = 8'h40;
      memory[12'h233] = 8'hA0;
      memory[12'h234] = 8'hE0;
      memory[12'h235] = 8'hA0;
      memory[12'h236] = 8'hE0;
      memory[12'h237] = 8'hC0;
      memory[12'h238] = 8'h80;
      memory[12'h239] = 8'hE0;
      memory[12'h23a] = 8'hE0;
      memory[12'h23b] = 8'h80;
      memory[12'h23c] = 8'hC0;
      memory[12'h23d] = 8'h80;
      memory[12'h23e] = 8'hA0;
      memory[12'h23f] = 8'h40;
      memory[12'h240] = 8'hA0;
      memory[12'h241] = 8'hA0;
      memory[12'h242] = 8'hA2;
      memory[12'h243] = 8'h02;
      memory[12'h244] = 8'hDA;
      memory[12'h245] = 8'hB4;
      memory[12'h246] = 8'h00;
      memory[12'h247] = 8'hEE;
      memory[12'h248] = 8'hA2;
      memory[12'h249] = 8'h02;
      memory[12'h24a] = 8'hDA;
      memory[12'h24b] = 8'hB4;
      memory[12'h24c] = 8'h13;
      memory[12'h24d] = 8'hDC;
      memory[12'h24e] = 8'h68;
      memory[12'h24f] = 8'h01;
      memory[12'h250] = 8'h69;
      memory[12'h251] = 8'h05;
      memory[12'h252] = 8'h6A;
      memory[12'h253] = 8'h0A;
      memory[12'h254] = 8'h6B;
      memory[12'h255] = 8'h01;
      memory[12'h256] = 8'h65;
      memory[12'h257] = 8'h2A;
      memory[12'h258] = 8'h66;
      memory[12'h259] = 8'h2B;
      memory[12'h25a] = 8'hA2;
      memory[12'h25b] = 8'h16;
      memory[12'h25c] = 8'hD8;
      memory[12'h25d] = 8'hB4;
      memory[12'h25e] = 8'hA2;
      memory[12'h25f] = 8'h3E;
      memory[12'h260] = 8'hD9;
      memory[12'h261] = 8'hB4;
      memory[12'h262] = 8'hA2;
      memory[12'h263] = 8'h02;
      memory[12'h264] = 8'h36;
      memory[12'h265] = 8'h2B;
      memory[12'h266] = 8'hA2;
      memory[12'h267] = 8'h06;
      memory[12'h268] = 8'hDA;
      memory[12'h269] = 8'hB4;
      memory[12'h26a] = 8'h6B;
      memory[12'h26b] = 8'h06;
      memory[12'h26c] = 8'hA2;
      memory[12'h26d] = 8'h1A;
      memory[12'h26e] = 8'hD8;
      memory[12'h26f] = 8'hB4;
      memory[12'h270] = 8'hA2;
      memory[12'h271] = 8'h3E;
      memory[12'h272] = 8'hD9;
      memory[12'h273] = 8'hB4;
      memory[12'h274] = 8'hA2;
      memory[12'h275] = 8'h06;
      memory[12'h276] = 8'h45;
      memory[12'h277] = 8'h2A;
      memory[12'h278] = 8'hA2;
      memory[12'h279] = 8'h02;
      memory[12'h27a] = 8'hDA;
      memory[12'h27b] = 8'hB4;
      memory[12'h27c] = 8'h6B;
      memory[12'h27d] = 8'h0B;
      memory[12'h27e] = 8'hA2;
      memory[12'h27f] = 8'h1E;
      memory[12'h280] = 8'hD8;
      memory[12'h281] = 8'hB4;
      memory[12'h282] = 8'hA2;
      memory[12'h283] = 8'h3E;
      memory[12'h284] = 8'hD9;
      memory[12'h285] = 8'hB4;
      memory[12'h286] = 8'hA2;
      memory[12'h287] = 8'h06;
      memory[12'h288] = 8'h55;
      memory[12'h289] = 8'h60;
      memory[12'h28a] = 8'hA2;
      memory[12'h28b] = 8'h02;
      memory[12'h28c] = 8'hDA;
      memory[12'h28d] = 8'hB4;
      memory[12'h28e] = 8'h6B;
      memory[12'h28f] = 8'h10;
      memory[12'h290] = 8'hA2;
      memory[12'h291] = 8'h26;
      memory[12'h292] = 8'hD8;
      memory[12'h293] = 8'hB4;
      memory[12'h294] = 8'hA2;
      memory[12'h295] = 8'h3E;
      memory[12'h296] = 8'hD9;
      memory[12'h297] = 8'hB4;
      memory[12'h298] = 8'hA2;
      memory[12'h299] = 8'h06;
      memory[12'h29a] = 8'h76;
      memory[12'h29b] = 8'hFF;
      memory[12'h29c] = 8'h46;
      memory[12'h29d] = 8'h2A;
      memory[12'h29e] = 8'hA2;
      memory[12'h29f] = 8'h02;
      memory[12'h2a0] = 8'hDA;
      memory[12'h2a1] = 8'hB4;
      memory[12'h2a2] = 8'h6B;
      memory[12'h2a3] = 8'h15;
      memory[12'h2a4] = 8'hA2;
      memory[12'h2a5] = 8'h2E;
      memory[12'h2a6] = 8'hD8;
      memory[12'h2a7] = 8'hB4;
      memory[12'h2a8] = 8'hA2;
      memory[12'h2a9] = 8'h3E;
      memory[12'h2aa] = 8'hD9;
      memory[12'h2ab] = 8'hB4;
      memory[12'h2ac] = 8'hA2;
      memory[12'h2ad] = 8'h06;
      memory[12'h2ae] = 8'h95;
      memory[12'h2af] = 8'h60;
      memory[12'h2b0] = 8'hA2;
      memory[12'h2b1] = 8'h02;
      memory[12'h2b2] = 8'hDA;
      memory[12'h2b3] = 8'hB4;
      memory[12'h2b4] = 8'h6B;
      memory[12'h2b5] = 8'h1A;
      memory[12'h2b6] = 8'hA2;
      memory[12'h2b7] = 8'h32;
      memory[12'h2b8] = 8'hD8;
      memory[12'h2b9] = 8'hB4;
      memory[12'h2ba] = 8'hA2;
      memory[12'h2bb] = 8'h3E;
      memory[12'h2bc] = 8'hD9;
      memory[12'h2bd] = 8'hB4;
      memory[12'h2be] = 8'h22;
      memory[12'h2bf] = 8'h42;
      memory[12'h2c0] = 8'h68;
      memory[12'h2c1] = 8'h17;
      memory[12'h2c2] = 8'h69;
      memory[12'h2c3] = 8'h1B;
      memory[12'h2c4] = 8'h6A;
      memory[12'h2c5] = 8'h20;
      memory[12'h2c6] = 8'h6B;
      memory[12'h2c7] = 8'h01;
      memory[12'h2c8] = 8'hA2;
      memory[12'h2c9] = 8'h0A;
      memory[12'h2ca] = 8'hD8;
      memory[12'h2cb] = 8'hB4;
      memory[12'h2cc] = 8'hA2;
      memory[12'h2cd] = 8'h36;
      memory[12'h2ce] = 8'hD9;
      memory[12'h2cf] = 8'hB4;
      memory[12'h2d0] = 8'hA2;
      memory[12'h2d1] = 8'h02;
      memory[12'h2d2] = 8'hDA;
      memory[12'h2d3] = 8'hB4;
      memory[12'h2d4] = 8'h6B;
      memory[12'h2d5] = 8'h06;
      memory[12'h2d6] = 8'hA2;
      memory[12'h2d7] = 8'h2A;
      memory[12'h2d8] = 8'hD8;
      memory[12'h2d9] = 8'hB4;
      memory[12'h2da] = 8'hA2;
      memory[12'h2db] = 8'h0A;
      memory[12'h2dc] = 8'hD9;
      memory[12'h2dd] = 8'hB4;
      memory[12'h2de] = 8'hA2;
      memory[12'h2df] = 8'h06;
      memory[12'h2e0] = 8'h87;
      memory[12'h2e1] = 8'h50;
      memory[12'h2e2] = 8'h47;
      memory[12'h2e3] = 8'h2A;
      memory[12'h2e4] = 8'hA2;
      memory[12'h2e5] = 8'h02;
      memory[12'h2e6] = 8'hDA;
      memory[12'h2e7] = 8'hB4;
      memory[12'h2e8] = 8'h6B;
      memory[12'h2e9] = 8'h0B;
      memory[12'h2ea] = 8'hA2;
      memory[12'h2eb] = 8'h2A;
      memory[12'h2ec] = 8'hD8;
      memory[12'h2ed] = 8'hB4;
      memory[12'h2ee] = 8'hA2;
      memory[12'h2ef] = 8'h0E;
      memory[12'h2f0] = 8'hD9;
      memory[12'h2f1] = 8'hB4;
      memory[12'h2f2] = 8'hA2;
      memory[12'h2f3] = 8'h06;
      memory[12'h2f4] = 8'h67;
      memory[12'h2f5] = 8'h2A;
      memory[12'h2f6] = 8'h87;
      memory[12'h2f7] = 8'hB1;
      memory[12'h2f8] = 8'h47;
      memory[12'h2f9] = 8'h2B;
      memory[12'h2fa] = 8'hA2;
      memory[12'h2fb] = 8'h02;
      memory[12'h2fc] = 8'hDA;
      memory[12'h2fd] = 8'hB4;
      memory[12'h2fe] = 8'h6B;
      memory[12'h2ff] = 8'h10;
      memory[12'h300] = 8'hA2;
      memory[12'h301] = 8'h2A;
      memory[12'h302] = 8'hD8;
      memory[12'h303] = 8'hB4;
      memory[12'h304] = 8'hA2;
      memory[12'h305] = 8'h12;
      memory[12'h306] = 8'hD9;
      memory[12'h307] = 8'hB4;
      memory[12'h308] = 8'hA2;
      memory[12'h309] = 8'h06;
      memory[12'h30a] = 8'h66;
      memory[12'h30b] = 8'h78;
      memory[12'h30c] = 8'h67;
      memory[12'h30d] = 8'h1F;
      memory[12'h30e] = 8'h87;
      memory[12'h30f] = 8'h62;
      memory[12'h310] = 8'h47;
      memory[12'h311] = 8'h18;
      memory[12'h312] = 8'hA2;
      memory[12'h313] = 8'h02;
      memory[12'h314] = 8'hDA;
      memory[12'h315] = 8'hB4;
      memory[12'h316] = 8'h6B;
      memory[12'h317] = 8'h15;
      memory[12'h318] = 8'hA2;
      memory[12'h319] = 8'h2A;
      memory[12'h31a] = 8'hD8;
      memory[12'h31b] = 8'hB4;
      memory[12'h31c] = 8'hA2;
      memory[12'h31d] = 8'h16;
      memory[12'h31e] = 8'hD9;
      memory[12'h31f] = 8'hB4;
      memory[12'h320] = 8'hA2;
      memory[12'h321] = 8'h06;
      memory[12'h322] = 8'h66;
      memory[12'h323] = 8'h78;
      memory[12'h324] = 8'h67;
      memory[12'h325] = 8'h1F;
      memory[12'h326] = 8'h87;
      memory[12'h327] = 8'h63;
      memory[12'h328] = 8'h47;
      memory[12'h329] = 8'h67;
      memory[12'h32a] = 8'hA2;
      memory[12'h32b] = 8'h02;
      memory[12'h32c] = 8'hDA;
      memory[12'h32d] = 8'hB4;
      memory[12'h32e] = 8'h6B;
      memory[12'h32f] = 8'h1A;
      memory[12'h330] = 8'hA2;
      memory[12'h331] = 8'h2A;
      memory[12'h332] = 8'hD8;
      memory[12'h333] = 8'hB4;
      memory[12'h334] = 8'hA2;
      memory[12'h335] = 8'h1A;
      memory[12'h336] = 8'hD9;
      memory[12'h337] = 8'hB4;
      memory[12'h338] = 8'hA2;
      memory[12'h339] = 8'h06;
      memory[12'h33a] = 8'h66;
      memory[12'h33b] = 8'h8C;
      memory[12'h33c] = 8'h67;
      memory[12'h33d] = 8'h8C;
      memory[12'h33e] = 8'h87;
      memory[12'h33f] = 8'h64;
      memory[12'h340] = 8'h47;
      memory[12'h341] = 8'h18;
      memory[12'h342] = 8'hA2;
      memory[12'h343] = 8'h02;
      memory[12'h344] = 8'hDA;
      memory[12'h345] = 8'hB4;
      memory[12'h346] = 8'h68;
      memory[12'h347] = 8'h2C;
      memory[12'h348] = 8'h69;
      memory[12'h349] = 8'h30;
      memory[12'h34a] = 8'h6A;
      memory[12'h34b] = 8'h34;
      memory[12'h34c] = 8'h6B;
      memory[12'h34d] = 8'h01;
      memory[12'h34e] = 8'hA2;
      memory[12'h34f] = 8'h2A;
      memory[12'h350] = 8'hD8;
      memory[12'h351] = 8'hB4;
      memory[12'h352] = 8'hA2;
      memory[12'h353] = 8'h1E;
      memory[12'h354] = 8'hD9;
      memory[12'h355] = 8'hB4;
      memory[12'h356] = 8'hA2;
      memory[12'h357] = 8'h06;
      memory[12'h358] = 8'h66;
      memory[12'h359] = 8'h8C;
      memory[12'h35a] = 8'h67;
      memory[12'h35b] = 8'h78;
      memory[12'h35c] = 8'h87;
      memory[12'h35d] = 8'h65;
      memory[12'h35e] = 8'h47;
      memory[12'h35f] = 8'hEC;
      memory[12'h360] = 8'hA2;
      memory[12'h361] = 8'h02;
      memory[12'h362] = 8'hDA;
      memory[12'h363] = 8'hB4;
      memory[12'h364] = 8'h6B;
      memory[12'h365] = 8'h06;
      memory[12'h366] = 8'hA2;
      memory[12'h367] = 8'h2A;
      memory[12'h368] = 8'hD8;
      memory[12'h369] = 8'hB4;
      memory[12'h36a] = 8'hA2;
      memory[12'h36b] = 8'h22;
      memory[12'h36c] = 8'hD9;
      memory[12'h36d] = 8'hB4;
      memory[12'h36e] = 8'hA2;
      memory[12'h36f] = 8'h06;
      memory[12'h370] = 8'h66;
      memory[12'h371] = 8'hE0;
      memory[12'h372] = 8'h86;
      memory[12'h373] = 8'h6E;
      memory[12'h374] = 8'h46;
      memory[12'h375] = 8'hC0;
      memory[12'h376] = 8'hA2;
      memory[12'h377] = 8'h02;
      memory[12'h378] = 8'hDA;
      memory[12'h379] = 8'hB4;
      memory[12'h37a] = 8'h6B;
      memory[12'h37b] = 8'h0B;
      memory[12'h37c] = 8'hA2;
      memory[12'h37d] = 8'h2A;
      memory[12'h37e] = 8'hD8;
      memory[12'h37f] = 8'hB4;
      memory[12'h380] = 8'hA2;
      memory[12'h381] = 8'h36;
      memory[12'h382] = 8'hD9;
      memory[12'h383] = 8'hB4;
      memory[12'h384] = 8'hA2;
      memory[12'h385] = 8'h06;
      memory[12'h386] = 8'h66;
      memory[12'h387] = 8'h0F;
      memory[12'h388] = 8'h86;
      memory[12'h389] = 8'h66;
      memory[12'h38a] = 8'h46;
      memory[12'h38b] = 8'h07;
      memory[12'h38c] = 8'hA2;
      memory[12'h38d] = 8'h02;
      memory[12'h38e] = 8'hDA;
      memory[12'h38f] = 8'hB4;
      memory[12'h390] = 8'h6B;
      memory[12'h391] = 8'h10;
      memory[12'h392] = 8'hA2;
      memory[12'h393] = 8'h3A;
      memory[12'h394] = 8'hD8;
      memory[12'h395] = 8'hB4;
      memory[12'h396] = 8'hA2;
      memory[12'h397] = 8'h1E;
      memory[12'h398] = 8'hD9;
      memory[12'h399] = 8'hB4;
      memory[12'h39a] = 8'hA3;
      memory[12'h39b] = 8'hE8;
      memory[12'h39c] = 8'h60;
      memory[12'h39d] = 8'h00;
      memory[12'h39e] = 8'h61;
      memory[12'h39f] = 8'h30;
      memory[12'h3a0] = 8'hF1;
      memory[12'h3a1] = 8'h55;
      memory[12'h3a2] = 8'hA3;
      memory[12'h3a3] = 8'hE9;
      memory[12'h3a4] = 8'hF0;
      memory[12'h3a5] = 8'h65;
      memory[12'h3a6] = 8'hA2;
      memory[12'h3a7] = 8'h06;
      memory[12'h3a8] = 8'h40;
      memory[12'h3a9] = 8'h30;
      memory[12'h3aa] = 8'hA2;
      memory[12'h3ab] = 8'h02;
      memory[12'h3ac] = 8'hDA;
      memory[12'h3ad] = 8'hB4;
      memory[12'h3ae] = 8'h6B;
      memory[12'h3af] = 8'h15;
      memory[12'h3b0] = 8'hA2;
      memory[12'h3b1] = 8'h3A;
      memory[12'h3b2] = 8'hD8;
      memory[12'h3b3] = 8'hB4;
      memory[12'h3b4] = 8'hA2;
      memory[12'h3b5] = 8'h16;
      memory[12'h3b6] = 8'hD9;
      memory[12'h3b7] = 8'hB4;
      memory[12'h3b8] = 8'hA3;
      memory[12'h3b9] = 8'hE8;
      memory[12'h3ba] = 8'h66;
      memory[12'h3bb] = 8'h89;
      memory[12'h3bc] = 8'hF6;
      memory[12'h3bd] = 8'h33;
      memory[12'h3be] = 8'hF2;
      memory[12'h3bf] = 8'h65;
      memory[12'h3c0] = 8'hA2;
      memory[12'h3c1] = 8'h02;
      memory[12'h3c2] = 8'h30;
      memory[12'h3c3] = 8'h01;
      memory[12'h3c4] = 8'hA2;
      memory[12'h3c5] = 8'h06;
      memory[12'h3c6] = 8'h31;
      memory[12'h3c7] = 8'h03;
      memory[12'h3c8] = 8'hA2;
      memory[12'h3c9] = 8'h06;
      memory[12'h3ca] = 8'h32;
      memory[12'h3cb] = 8'h07;
      memory[12'h3cc] = 8'hA2;
      memory[12'h3cd] = 8'h06;
      memory[12'h3ce] = 8'hDA;
      memory[12'h3cf] = 8'hB4;
      memory[12'h3d0] = 8'h6B;
      memory[12'h3d1] = 8'h1A;
      memory[12'h3d2] = 8'hA2;
      memory[12'h3d3] = 8'h0E;
      memory[12'h3d4] = 8'hD8;
      memory[12'h3d5] = 8'hB4;
      memory[12'h3d6] = 8'hA2;
      memory[12'h3d7] = 8'h3E;
      memory[12'h3d8] = 8'hD9;
      memory[12'h3d9] = 8'hB4;
      memory[12'h3da] = 8'h12;
      memory[12'h3db] = 8'h48;
      memory[12'h3dc] = 8'h13;
      memory[12'h3dd] = 8'hDC;
    end
  end
  `endif
  
  always @(posedge clk) begin
    if(write)
      memory[address] <= data;
  end
  
  assign data = select ? memory[address] : 8'bz;

endmodule;

`endif // RAM_V