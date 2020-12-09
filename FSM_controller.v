`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2020 01:22:57 AM
// Design Name: 
// Module Name: FSM_controller
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


module FSM_controller(clk,reset,player1,player2,bingo1,bingo2,lifeOut1,lifeOut2,who,player1_play,player2_play);
input clk, reset; 
input player1, player2; 
input bingo1, bingo2; // high if one of the players guess correct number
input [1:0]lifeOut1; // result of remaining player 1's life count
input [1:0]lifeOut2; // result of remaining player 2's life count 
output reg [1:0]who; // 0 if draw, 1 if player1 wins, 2 if player2 wins.
output reg player1_play;
output reg player2_play;

 parameter INITIAL= 2'b00; 
 parameter PLAYER1 = 2'b01; 
 parameter PLAYER2 = 2'b10; 
 parameter GAME_FIN = 2'b11; 
 reg [1:0] Current_state, Next_state; 
 
 always @(posedge clk or posedge reset)
 begin 
 if (reset) 
    Current_state <= INITIAL; 
 else 
    Current_state <= Next_state;
 end
 
 always @(*)
 begin 
 case(Current_state) 
 INITIAL: begin 
    if (reset== 1'b0 && player1 == 1'b1)
        Next_state <= PLAYER1; 
    else
        Next_state <= INITIAL; 
        player1_play <= 1'b0; 
        player2_play <= 1'b0;
    end     
 PLAYER1: begin 
    player1_play <= 1'b1; 
    player2_play <= 1'b0; 
    if (bingo1 == 1'b0)
        Next_state <= PLAYER2; 
    else 
        Next_state <= GAME_FIN; 
     end 
 PLAYER2: begin 
    player1_play <= 1'b0;  
    if (player2 == 1'b0) begin 
        Next_state <= PLAYER2;  
        player2_play <= 1'b0; 
    end
    else if(bingo2 == 1'b0 && lifeOut2 != 0) begin
        Next_state <= PLAYER1; 
        player2_play <= 1'b1;
    end
    else if(bingo2 == 1'b1 || (bingo2 == 1'b0 && lifeOut2 == 0))begin
        Next_state <= GAME_FIN;
        player2_play <= 1'b1;
        end
    end
 GAME_FIN: begin 
    player1_play <= 1'b0; 
    player2_play <= 1'b0; 
 
    if (reset == 1'b1)
        Next_state <= INITIAL; 
    else 
        if (lifeOut1 == 0 && lifeOut2 == 0 && bingo1 == 0 && bingo2 == 0) begin
            who <= 2'b00; end 
        else if(bingo1 == 1 && bingo2 == 0) begin
            who <= 2'b01; end
        else if(bingo2 == 1 && bingo1 == 0) begin 
            who <= 2'b10; end       
        Next_state <= GAME_FIN; 
    end
 default: Next_state <= INITIAL; 
 endcase
    end
endmodule
