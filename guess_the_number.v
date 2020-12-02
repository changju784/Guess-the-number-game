`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 02:11:14 AM
// Design Name: 
// Module Name: guess_the_number
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


module guess_the_number(clk,reset,timerOut,num,gnum,low, high, bingo, livesOut);
input clk,reset,timerOut; //timerOutput from 10 sec timer
input [3:0] num; // random number from lfsr
input [3:0] gnum; // number player guesses
output reg low, high, bingo; // state of the guessed number
output reg [1:0] livesOut; // life count starting from 3

initial begin 
low = 1'b0;
high = 1'b0;
bingo = 1'b0;
livesOut = 2'b11;
end
always@ (posedge clk, posedge reset, posedge timerOut) begin 
    if (!reset) begin
        if(!timerOut) begin 
            if (gnum > num) begin
                livesOut = livesOut - 2'b01;
                high <= 1'b1; end
            else if (gnum < num) begin
                livesOut = livesOut - 2'b01;  
                low <= 1'b1; end
            else begin
                bingo <= 1'b1; end
        end
        else if(timerOut) begin
            livesOut = livesOut - 2'b01;
        end
     end
 end
 
endmodule
