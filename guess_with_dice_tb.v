`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2020 07:32:43 AM
// Design Name: 
// Module Name: guess_with_dice_tb
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


module guess_with_dice_tb();
reg RESET,CLK,NEW_GAME,ROLL,HOLD;
reg [6:0] lfsr_result;
wire [6:0] seg1_1;
wire [6:0] seg1_10; 
wire [6:0] seg2_1;
wire [6:0] seg2_10;
wire [6:0] segsum_1; 
wire [6:0] segsum_10;
wire [6:0] segdice;
wire P1, P2;
guess_with_dice UTT(NEW_GAME,RESET,ROLL,HOLD,CLK,lfsr_result,seg1_1,seg1_10,seg2_1,seg2_10,segsum_1,segsum_10,segdice,P1,P2);
initial begin 
RESET = 1; 
NEW_GAME = 0;
ROLL = 0; 
HOLD = 0; 
lfsr_result = 7'b1111111;
#20; 
RESET = 0;
#30;
ROLL = 1;
#31;
ROLL = 0;
#80; 
ROLL = 1;
#81; 
ROLL = 0; 
#120;
HOLD = 1;
#121; 
HOLD = 0; 
#160;
ROLL = 1;
#161; 
ROLL = 0;
#200; 
ROLL = 1; 
#220;
ROLL = 0; 
#300; 
NEW_GAME = 1;
#310;
NEW_GAME = 0;
end

initial begin CLK = 1; forever #0.05 CLK = ~CLK; end

endmodule
