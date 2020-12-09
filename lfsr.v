`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2020 11:57:16 PM
// Design Name: 
// Module Name: lfsr
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


module lfsr (clk,reset,out);
  input clk, reset;
  output reg [6:0] out;
  wire feedback;
  
assign feedback = ~(out[6] ^ out[5]);

always @(posedge clk, posedge reset)
  begin
    if (reset)
      out = 7'b0000000;
    else
      out = {out[6:0],feedback};
  end
endmodule
