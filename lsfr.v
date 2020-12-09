`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 06:42:33
// Design Name: 
// Module Name: lsfr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lfsr (clk,reset,NEWGAME,out);
  input clk, reset, NEWGAME;
  output reg [6:0] out;
  wire feedback;
  
assign feedback = ~(out[6] ^ out[5]);

always @(posedge clk)
  begin
    if (reset==0 || NEWGAME == 1)
      out = {out[5:0],feedback};
  end
endmodule