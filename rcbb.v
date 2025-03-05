`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 20:57:23
// Design Name: 
// Module Name: pbb
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


module rcbb(input [1:0]md,
  input [1:0]mr,
  input wire sx,
  input wire sy,
  output [4:0]p
    );
    
    
    wire [2:0]x,y;
    wire a,b;
    
    assign x=({sx&md[1],md[1:0]});
    assign y=({sy&mr[1],mr[1:0]});
    
    assign a=~x[2]&x[1]&x[0];
    assign b=~y[2]&y[1]&y[0];
    
       
    wire w1,w2,w3,w4;
    assign w4 = (a&b);
    
    assign p[0]=x[0]&y[0];
    half ha1(x[1]&y[0],x[0]&y[1],p[1],w1);   
    xor x1(w2,w1,x[1]&y[1]);
    xor x2(w3,~(x[2]&y[0]),~(x[0]&y[2]));
    xor x3(p[2],w2,w3);
    assign p[4]=(x[2]^y[2])&(x[1]|x[0])&(y[1]|y[0]);
    
    
    assign p[3] = w4 ^ p[4];
    

    
endmodule



