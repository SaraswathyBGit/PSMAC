`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 16:03:23
// Design Name: 
// Module Name: rcbbus
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


module rcbbsuss(input [1:0]md,
  input [1:0]mr,
  input wire sx,
  input wire sy,
  output [4:0]p
    );
    
    
    wire [2:0]x,y;
    
    wire a,b,c;
    wire w1;

   assign a=x[2]&x[1]&~x[0];
   assign b=~y[2]&y[1]&y[0];
   assign c=y[2]&y[1]&~y[0];
 
   
    
    assign x=({sx&md[1],md[1:0]});
    assign y=({sy&mr[1],mr[1:0]});
    
    assign w1=(a&b)|(a&c);
       
  
   
    assign p[0]=x[0]&y[0];
    xor x1(p[1],x[1]&y[0],x[0]&y[1]);  
    assign p[4]=(x[2]^y[2])&(x[1]|x[0])&(y[1]|y[0]);     
    assign p[3]=p[4];
    assign p[2]=w1^(p[4]);
    

    
endmodule
