`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 06:46:20
// Design Name: 
// Module Name: top
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


module top(NEW_GAME,CLK,RESET,reset,ROLL,HOLD,seg1_1,seg1_10,seg2_1,seg2_10,segsum_1,segsum_10,segdice,P1,P2);

input RESET,CLK,NEW_GAME,ROLL,HOLD,reset;
output [6:0] seg1_1;
output [6:0] seg1_10; 
output [6:0] seg2_1;
output [6:0] seg2_10;
output [6:0] segsum_1; 
output [6:0] segsum_10;
output [6:0] segdice;
output P1, P2;
wire [6:0] lfsr_result;

lfsr lfs(.clk(CLK),.reset(reset),.out(lfsr_result));
guess_with_dice gwd(NEW_GAME,RESET,ROLL,HOLD,CLK,lfsr_result,seg1_1,seg1_10,seg2_1,seg2_10,segsum_1,segsum_10,segdice,P1,P2);

endmodule
