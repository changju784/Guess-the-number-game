`timescale 1ns / 1ps

module vgacontroller(
    input clk,
    input [4:0] HH,
    input [5:0] MM,
    input [5:0] SS,
    output Hsynq,
    output Vsynq,
    output [3:0] Red,
    output [3:0] Green,
    output [3:0] Blue
    );
    
wire clk_25M;
wire enable_V_Counter;
wire [15:0] H_Count_Value;
wire [15:0] V_Count_Value;
integer Pixel_SizeH = 12;  // half the length of the square
integer Pixel_SizeV = 30;  // half the length of the square
integer locH=340, locV=50;  //default start pixel location 
integer space=40;
integer numlocHHdec =1, numlocHHone =1, numlocMMone=1, numlocMMdec =1, numlocSSone=1, numlocSSdec; //this whole thing is for this to be 1/0
//wire [4:0] HH=5'b01111; //hour input
//wire [5:0] MM=6'b100010; //minute input
//wire [5:0] SS=6'b110001; //second input 
wire [4:0]MMdec, MMone; //convert input vector to 1number
wire [4:0]HHone, HHdec;
wire [4:0]SSone, SSdec;

clock_divider VGA_Clock_gen (clk, clk_25M);
horizontal_counter VGA_Horiz (clk_25M, enable_V_Counter, H_Count_Value);
vertical_counter VGA_Verti (clk_25M, enable_V_Counter, V_Count_Value);
bin_to_dec b2(.bin_num(HH), .dec_num1(HHdec), .dec_num2(HHone));
bin_to_dec b3(.bin_num(MM), .dec_num1(MMdec), .dec_num2(MMone));
bin_to_dec b4(.bin_num(SS), .dec_num1(SSdec), .dec_num2(SSone));

//out
assign Hsynq = (H_Count_Value < 96) ? 1'b1:1'b0;
assign Vsynq = (V_Count_Value < 2) ? 1'b1:1'b0;

// pixel check if false then black
always @(H_Count_Value or V_Count_Value or HH or MM or SS) begin //add time once all put together

if (HHdec == 4'b0000) begin
     if ( H_Count_Value < locH+Pixel_SizeH && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)  
            numlocHHdec=1;
end

if (HHdec == 4'b0001) begin 
    if ( H_Count_Value < locH+Pixel_SizeH  && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)
            numlocHHdec=0;
         else 
            numlocHHdec=1;
end

if (HHdec == 4'b0010) begin 
    if ( H_Count_Value < locH+Pixel_SizeH  && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*2 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHdec=0;
         else 
            numlocHHdec=1;
end
if (HHdec == 4'b0011) begin 
    if ( H_Count_Value < locH+Pixel_SizeH  && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*3 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHdec=0;
         else 
            numlocHHdec=1;
end
if (HHdec == 4'b0100) begin 
    if ( H_Count_Value < locH+Pixel_SizeH  && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*4 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHdec=0;
         else 
            numlocHHdec=1;
end
if (HHdec == 4'b0101) begin 
    if ( H_Count_Value < locH+Pixel_SizeH  && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*5 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHdec=0;
         else 
            numlocHHdec=1;
end
if (HHdec == 4'b0110) begin 
    if ( H_Count_Value < locH+Pixel_SizeH  && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*6 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHdec=0;
         else 
            numlocHHdec=1;
end
///////////////////////////////////////////////////HHone

if (HHone == 4'b0000) begin
     if ( H_Count_Value < locH+space+Pixel_SizeH && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)  
            numlocHHone=1;
end

if (HHone == 4'b0001) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end

if (HHone == 4'b0010) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*2 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end
if (HHone == 4'b0011) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*3 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end
if (HHone == 4'b0100) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*4 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end
if (HHone == 4'b0101) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*5 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end
if (HHone == 4'b0110) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*6 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end
if (HHone == 4'b0111) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*7 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end
if (HHone == 4'b1000) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*8 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end
if (HHone == 4'b1001) begin 
    if ( H_Count_Value < locH+space+Pixel_SizeH  && H_Count_Value > locH+space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*9 && V_Count_Value > locV-Pixel_SizeV)
            numlocHHone=0;
         else 
            numlocHHone=1;
end
////////////////////////////////////////MMdec
if (MMdec == 4'b0000) begin
     if ( H_Count_Value < locH+Pixel_SizeH && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)  
            numlocMMdec=1;
end

if (MMdec == 4'b0001) begin 
    if ( H_Count_Value < locH+3*space+Pixel_SizeH  && H_Count_Value > locH+3*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*1 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMdec=0;
         else 
            numlocMMdec=1;
end

if (MMdec == 4'b0010) begin 
    if ( H_Count_Value < locH+3*space+Pixel_SizeH  && H_Count_Value > locH+3*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*2 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMdec=0;
         else 
            numlocMMdec=1;
end
if (MMdec == 4'b0011) begin 
    if ( H_Count_Value < locH+3*space+Pixel_SizeH  && H_Count_Value > locH+3*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*3 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMdec=0;
         else 
            numlocMMdec=1;
end
if (MMdec == 4'b0100) begin 
    if ( H_Count_Value < locH+3*space+Pixel_SizeH  && H_Count_Value > locH+3*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*4 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMdec=0;
         else 
            numlocMMdec=1;
end
if (MMdec == 4'b0101) begin 
    if ( H_Count_Value < locH+3*space+Pixel_SizeH  && H_Count_Value > locH+3*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*5 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMdec=0;
         else 
            numlocMMdec=1;
end
if (MMdec == 4'b0110) begin 
    if ( H_Count_Value < locH+3*space+Pixel_SizeH  && H_Count_Value > locH+3*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*6 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMdec=0;
         else 
            numlocMMdec=1;
end
///////////////////////////////////////////////////MMone

if (MMone == 4'b0000) begin
     if ( H_Count_Value < locH+4*space+Pixel_SizeH && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)  
            numlocMMone=1;
end

if (MMone == 4'b0001) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end

if (MMone == 4'b0010) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*2 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end
if (MMone == 4'b0011) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*3 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end
if (MMone == 4'b0100) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*4 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end
if (MMone == 4'b0101) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*5 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end
if (MMone == 4'b0110) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*6 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end
if (MMone == 4'b0111) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*7 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end
if (MMone == 4'b1000) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*8 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end
if (MMone == 4'b1001) begin 
    if ( H_Count_Value < locH+4*space+Pixel_SizeH  && H_Count_Value > locH+4*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*9 && V_Count_Value > locV-Pixel_SizeV)
            numlocMMone=0;
         else 
            numlocMMone=1;
end
///////////////////////////////////////////////SSdec
if (SSdec == 4'b0000) begin
     if ( H_Count_Value < locH+Pixel_SizeH && H_Count_Value > locH-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)  
            numlocSSdec=1;
end

if (SSdec == 4'b0001) begin 
    if ( H_Count_Value < locH+6*space+Pixel_SizeH  && H_Count_Value > locH+6*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*1 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSdec=0;
         else 
            numlocSSdec=1;
end

if (SSdec == 4'b0010) begin 
    if ( H_Count_Value < locH+6*space+Pixel_SizeH  && H_Count_Value > locH+6*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*2 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSdec=0;
         else 
            numlocSSdec=1;
end
if (SSdec == 4'b0011) begin 
    if ( H_Count_Value < locH+6*space+Pixel_SizeH  && H_Count_Value > locH+6*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*3 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSdec=0;
         else 
            numlocSSdec=1;
end
if (SSdec == 4'b0100) begin 
    if ( H_Count_Value < locH+6*space+Pixel_SizeH  && H_Count_Value > locH+6*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*4 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSdec=0;
         else 
            numlocSSdec=1;
end
if (SSdec == 4'b0101) begin 
    if ( H_Count_Value < locH+6*space+Pixel_SizeH  && H_Count_Value > locH+6*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*5 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSdec=0;
         else 
            numlocSSdec=1;
end
if (SSdec == 4'b0110) begin 
    if ( H_Count_Value < locH+6*space+Pixel_SizeH  && H_Count_Value > locH+6*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*6 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSdec=0;
         else 
            numlocSSdec=1;
end
///////////////////////////////////////////////////SSone

if (SSone == 4'b0000) begin
     if ( H_Count_Value < locH+7*space+Pixel_SizeH && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)  
            numlocSSone=1;
end

if (SSone == 4'b0001) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end

if (SSone == 4'b0010) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*2 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end
if (SSone == 4'b0011) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*3 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end
if (SSone == 4'b0100) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*4 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end
if (SSone == 4'b0101) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*5 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end
if (SSone == 4'b0110) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*6 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end
if (SSone == 4'b0111) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*7 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end
if (SSone == 4'b1000) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*8 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end
if (SSone == 4'b1001) begin 
    if ( H_Count_Value < locH+7*space+Pixel_SizeH  && H_Count_Value > locH+7*space-Pixel_SizeH && V_Count_Value < locV+Pixel_SizeV*9 && V_Count_Value > locV-Pixel_SizeV)
            numlocSSone=0;
         else 
            numlocSSone=1;
end
end  //always@ end 
 
assign Red = (H_Count_Value < 784 && H_Count_Value > 143 && V_Count_Value < 515 && V_Count_Value > 34 && numlocHHdec==1'b1 && numlocHHone==1'b1 && numlocMMdec==1'b1 && numlocMMone==1'b1 && numlocSSdec==1'b1 && numlocSSone==1'b1) ? 4'hF:4'h0;
assign Green = (H_Count_Value < 784 && H_Count_Value > 143 && V_Count_Value < 515 && V_Count_Value > 34 && numlocHHdec==1'b1 && numlocHHone==1'b1 && numlocMMdec==1'b1 && numlocMMone==1'b1 && numlocSSdec==1'b1 && numlocSSone==1'b1) ? 4'hF:4'h0;
assign Blue = (H_Count_Value < 784 && H_Count_Value > 143 && V_Count_Value < 515 && V_Count_Value > 34 && numlocHHdec==1'b1 && numlocHHone==1'b1 && numlocMMdec==1'b1 && numlocMMone==1'b1 && numlocSSdec==1'b1 && numlocSSone==1'b1) ? 4'hF:4'h0;

endmodule
