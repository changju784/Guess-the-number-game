`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: guess_with_dice
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


module guess_with_dice(NEW_GAME,RESET,ROLL,HOLD,CLK,lfsr_result,seg1_1,seg1_10,seg2_1,seg2_10,segsum_1,segsum_10,segdice,P1,P2);

input RESET,CLK,NEW_GAME,ROLL,HOLD;
input [6:0] lfsr_result;

output reg [6:0] seg1_1;
output reg [6:0] seg1_10; 
output reg [6:0] seg2_1;
output reg [6:0] seg2_10;
output reg [6:0] segsum_1; 
output reg [6:0] segsum_10;
output reg [6:0] segdice;
output P1, P2;

reg [6:0] PS1;
reg [6:0] PS2;
reg [6:0] SUM;
reg [19:0] Clk_div;
reg [30:0] Clk_div2;
reg P1 = 1, P2 = 0;
reg NEW_PUSH=0;
reg ROLL_PUSH=0;
reg HOLD_PUSH=0;
reg [6:0] rmd1,rmd2,rmd3,rmd4,rmd5,rmd6;

reg [6:0] TR1_1;
reg [6:0] TR1_10;
reg [6:0] TR2_1;
reg [6:0] TR2_10;
reg [6:0] TRSUM_1;
reg [6:0] TRSUM_10;
reg [2:0] DICE_ROLL;

always@(posedge CLK)
begin

// clock divider
          if(RESET==1)
          Clk_div = 20'd0;
        else
           Clk_div = Clk_div+20'd1;
            if(Clk_div==20'd500000)
             begin
             Clk_div=20'd0;

// dice operation
            
             if(ROLL_PUSH==1)
               begin
                   DICE_ROLL = DICE_ROLL + 3'b001;
                    if(DICE_ROLL == 3'b111)
                     begin
                     DICE_ROLL = 3'b001;
                     end
               end         
               end

// WIN BLINK
          if(RESET==1)
          Clk_div2 = 30'd0;
        else
           Clk_div2 = Clk_div2+30'd1;
            if(Clk_div2==30'd50000000)
             begin
             Clk_div2=30'd0;
            if(PS1 >= lfsr_result && P1 == 0 && HOLD_PUSH == 0)
            begin 
            P1 = 1;
            end
            else if(PS1 >= lfsr_result && P1 == 1 && HOLD_PUSH == 0)
            begin
            P1 = 0;
            end
            if(PS2 >= lfsr_result && P2 == 0 && HOLD_PUSH == 0)
            begin 
            P2 = 1;
            end
            else if(PS2 >= lfsr_result && P2 == 1 && HOLD_PUSH == 0)
            begin
            P2 = 0;
            end   
            end         

// PUSH 'RESET' Button

if(ROLL==0 && HOLD==0 && NEW_GAME==0 && RESET==1)
 begin
  PS1 = 7'b0000000;
  PS2 = 7'b0000000;
  SUM = 7'b0000000;
  DICE_ROLL = 3'b000;
  P1 = 1;
  P2 = 0;
 end

//PUSH 'NEW GAME' Button
if(NEW_GAME==1 && ROLL==0 && HOLD==0 && RESET==0)
 begin
  NEW_PUSH = 1;
 end
  else if(NEW_GAME==0 && NEW_PUSH==1)
   begin
   NEW_PUSH=0;
  if(P1==1 || (PS1 >= lfsr_result && P1 == 0))
   begin
    P1=0;
    P2=1;
   end
  else if(P2==1 || (PS2 >= lfsr_result && P2 == 0))
   begin
    P1=1;
    P2=0;
   end
  PS1 = 7'b0000000;
  PS2 = 7'b0000000;
  SUM = 7'b0000000;
  DICE_ROLL = 3'b000;
   end

//PUSH 'ROLL' Button

if(ROLL==1 && ROLL_PUSH==0)
 begin
  ROLL_PUSH=1;
 end
  else if(ROLL==0 && ROLL_PUSH==1)
   begin
    ROLL_PUSH=0;
     if(P1==1)
     begin
      if(DICE_ROLL == 3'b001)
       begin
        SUM = 7'b0000000;
        P1=0;
        P2=1;
       end
       else
        SUM = SUM + DICE_ROLL;
     end
     else if(P2==1)
      begin
       if(DICE_ROLL == 3'b001)
        begin
         SUM = 7'b0000000;
         P1=1;
         P2=0;
        end
        else
         SUM = SUM + DICE_ROLL;
      end
   end
       else if((PS1 >= lfsr_result || PS2 >= lfsr_result) && ROLL == 1)
        begin
         DICE_ROLL = 3'b000;
        end

//PUSH 'HOLD' Button

 if(HOLD==1 && HOLD_PUSH==0)
  begin
   HOLD_PUSH = 1;
  end
   else if(HOLD==0 && HOLD_PUSH==1)
    begin
     HOLD_PUSH = 0;
     begin
      if(P1==1 && P2==0)
       begin
       PS1 = PS1 + SUM;
        P1 = 0;
        P2 = 1;
        SUM = 7'b0000000;
        if(PS1 >= lfsr_result)
         begin
         P1 = 1;
         P2 = 0;
         end
       end
   else if(P1==0 && P2==1)
    begin
     PS2 = PS2 + SUM;
      P1 = 1;
      P2 = 0;
      SUM = 7'b0000000;
        if(PS2 >= lfsr_result)
         begin
         P1 = 0;
         P2 = 1;
         end
    end
   end
  end
end

//Score data

always@(posedge CLK)
 begin
//Player1
  rmd1 = PS1 % lfsr_result;
  TR1_10 = rmd1 / 7'b0001010;
  rmd2 = PS1 % 7'b0001010;
  TR1_1 = rmd2;

//Player2
  rmd3 = PS2 % lfsr_result;
  TR2_10 = rmd3 / 7'b0001010;
  rmd4 = PS2 % 7'b0001010;
  TR2_1 = rmd4;

//SUM
  rmd5 = SUM % lfsr_result;
  TRSUM_10 = rmd5 / 7'b0001010;
  rmd6 = SUM % 7'b0001010;
  TRSUM_1 = rmd6;
 end

//Segment Output

always@(posedge CLK)
begin
case(TR1_10)
7'b0000000:seg1_10=7'b1000000;
7'b0000001:seg1_10=7'b1111001;
7'b0000010:seg1_10=7'b0100100;
7'b0000011:seg1_10=7'b0110000;
7'b0000100:seg1_10=7'b0011001;
7'b0000101:seg1_10=7'b0010010;
7'b0000110:seg1_10=7'b0000010;
7'b0000111:seg1_10=7'b1011000;
7'b0001000:seg1_10=7'b0000000;
7'b0001001:seg1_10=7'b0010000;
endcase
case(TR1_1)
7'b0000000:seg1_1=7'b1000000;
7'b0000001:seg1_1=7'b1111001;
7'b0000010:seg1_1=7'b0100100;
7'b0000011:seg1_1=7'b0110000;
7'b0000100:seg1_1=7'b0011001;
7'b0000101:seg1_1=7'b0010010;
7'b0000110:seg1_1=7'b0000010;
7'b0000111:seg1_1=7'b1011000;
7'b0001000:seg1_1=7'b0000000;
7'b0001001:seg1_1=7'b0010000;
endcase
case(TR2_10)
7'b0000000:seg2_10=7'b1000000;
7'b0000001:seg2_10=7'b1111001;
7'b0000010:seg2_10=7'b0100100;
7'b0000011:seg2_10=7'b0110000;
7'b0000100:seg2_10=7'b0011001;
7'b0000101:seg2_10=7'b0010010;
7'b0000110:seg2_10=7'b0000010;
7'b0000111:seg2_10=7'b1011000;
7'b0001000:seg2_10=7'b0000000;
7'b0001001:seg2_10=7'b0010000;
endcase
case(TR2_1)
7'b0000000:seg2_1=7'b1000000;
7'b0000001:seg2_1=7'b1111001;
7'b0000010:seg2_1=7'b0100100;
7'b0000011:seg2_1=7'b0110000;
7'b0000100:seg2_1=7'b0011001;
7'b0000101:seg2_1=7'b0010010;
7'b0000110:seg2_1=7'b0000010;
7'b0000111:seg2_1=7'b1011000;
7'b0001000:seg2_1=7'b0000000;
7'b0001001:seg2_1=7'b0010000;
endcase
case(TRSUM_10)
7'b0000000:segsum_10=7'b1000000;
7'b0000001:segsum_10=7'b1111001;
7'b0000010:segsum_10=7'b0100100;
7'b0000011:segsum_10=7'b0110000;
7'b0000100:segsum_10=7'b0011001;
7'b0000101:segsum_10=7'b0010010;
7'b0000110:segsum_10=7'b0000010;
7'b0000111:segsum_10=7'b1011000;
7'b0001000:segsum_10=7'b0000000;
7'b0001001:segsum_10=7'b0010000;
endcase
case(TRSUM_1)
7'b0000000:segsum_1=7'b1000000;
7'b0000001:segsum_1=7'b1111001;
7'b0000010:segsum_1=7'b0100100;
7'b0000011:segsum_1=7'b0110000;
7'b0000100:segsum_1=7'b0011001;
7'b0000101:segsum_1=7'b0010010;
7'b0000110:segsum_1=7'b0000010;
7'b0000111:segsum_1=7'b1011000;
7'b0001000:segsum_1=7'b0000000;
7'b0001001:segsum_1=7'b0010000;
endcase
case(DICE_ROLL)
3'b000:segdice=7'b1000000;
3'b001:segdice=7'b1111001;
3'b010:segdice=7'b0100100;
3'b011:segdice=7'b0110000;
3'b100:segdice=7'b0011001;
3'b101:segdice=7'b0010010;
3'b110:segdice=7'b0000010;
endcase
end
endmodule
