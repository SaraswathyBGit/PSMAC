`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 10:57:23
// Design Name: 
// Module Name: bbu
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


module OAHFU(

  input [31:0]ip,
  input [31:0]wt,
  
  input [3:0]sx1,sx2,sx3,sx4,sy1,sy2,sy3,sy4,
  input mode1,mode2,clk,

  
  
   output reg signed [15:0]y
    
    );
    
    
    wire  [4:0] pr1,pr2,pr3,pr4,pr5,pr6,pr7,pr8,pr9,pr10,pr11,pr12,pr13,pr14,pr15,pr16;
    wire  [8:0] m1,m2,m3,m4; 
    wire  [8:0] mux11,mux12,mux21,mux22,mux31,mux32,mux41,mux42;
    wire  [8:0] sh1,sh2,sh3,sh4;
    wire  [4:0] a11,a12,a21,a22,a31,a32,a41,a42;
    wire  [8:0] sea11,sea12,sea21,sea22,sea31,sea32,sea41,sea42;

    wire  [7:0]ps1,ps4;
    wire signed [7:0] ps1,ps2;
    wire  [7:0] a1;
    wire  [15:0] merge,mux1,mux2;
    wire  [15:0] shift;
    wire  [15:0]sea1;
    wire signed [15:0]sea2;
    

    
    
    
    
 // products of 2bx2b

    rcbb uu1(ip[1:0],wt[1:0],sx1[0],sy1[0],pr1);
    rcbb uu2(ip[3:2],wt[3:2],sx1[1],sy1[1],pr2);
    rcbb uu3(ip[5:4],wt[5:4],sx1[2],sy1[2],pr3);
    rcbb uu4(ip[7:6],wt[7:6],sx1[3],sy1[3],pr4); 

    assign m1={pr4,pr1[3:0]};
    assign a11=pr4+pr1;   
    assign sea11=(pr4[4]||pr1[4])?({a11[4],a11[4],a11[4],a11[4],a11}):({4'b0000,a11});
    assign mux11= (mode1)?(m1): (sea11);

    assign a12=pr2+pr3;
    assign sea12=(pr2[4]||pr3[4])?({a12[4],a12[4],a12[4],a12[4],a12}):({4'b0000,a12});  
    assign sh1=sea12<<2;      
    assign mux12= (mode1)?(sh1): (sea12);

    assign ps1=mux11+mux12;


    

// products of 2bx2b 

    rcbb uu5(ip[9:8],wt[9:8],sx2[0],sy2[0],pr5);
    rcbbsuss su1(ip[11:10],wt[11:10],sx2[1],sy2[1],pr6);
    rcbb uu6(ip[13:12],wt[13:12],sx2[2],sy2[2],pr7);
    rcbbsuss su2(ip[15:14],wt[15:14],sx2[3],sy2[3],pr8); 
   
    assign m2={pr8,pr5[3:0]};
    assign a21=pr8+pr5;   
    assign sea21=(pr8[4]||pr5[4])?({a21[4],a21[4],a21[4],a21[4],a21}):({4'b0000,a21});
    assign mux21= (mode1)?(m2): (sea21);

    assign a22=pr6+pr7;   
    assign sea22=(pr6[4]||pr7[4])?({a22[4],a22[4],a22[4],a22[4],a22}):({4'b0000,a22});
    assign sh2=sea22<<2;      
    assign mux22= (mode1)?(sh2): (sea22);

    assign ps2=mux21+mux22;


    

// products of 2bx2b

    rcbb uu7(ip[17:16],wt[17:16],sx3[0],sy3[0],pr9);
    rcbb uu8(ip[19:18],wt[19:18],sx3[1],sy3[1],pr10);
    rcbbusss us1(ip[21:20],wt[21:20],sx3[2],sy3[2],pr11);
    rcbbusss us2(ip[23:22],wt[23:22],sx3[3],sy3[3],pr12); 
    
    assign m3={pr12,pr9[3:0]};
    assign a31=pr12+pr9;   
    assign sea31=(pr12[4]||pr9[4])?({a31[4],a31[4],a31[4],a31[4],a31}):({4'b0000,a31});
    assign mux31= (mode1)?(m3): (sea31);

    assign a32=pr10+pr11;   
    assign sea32=(pr10[4]||pr11[4])?({a32[4],a32[4],a32[4],a32[4],a32}):({4'b0000,a32});
    assign sh3=sea32<<2;      
    assign mux32= (mode1)?(sh3): (sea32);

    assign ps3=mux31+mux32;


    

// products of 2bx2b

    rcbb uu9(ip[25:24],wt[25:24],sx4[0],sy4[0],pr13);
    rcbbsuss su3(ip[27:26],wt[27:26],sx4[1],sy4[1],pr14);
    rcbbusss us3(ip[29:28],wt[29:28],sx4[2],sy4[2],pr15);
    rcbbss ss1(ip[31:30],wt[31:30],sx4[3],sy4[3],pr16); 

    
    assign m4={pr16,pr13[3:0]};
    assign a41=pr16+pr13;   
    assign sea41=(pr16[4]||pr13[4])?({a41[4],a41[4],a41[4],a41[4],a41}):({4'b0000,a41});
    assign mux41= (mode1)?(m4): (sea41);
    
    assign a42=pr14+pr15;   
    assign sea42=(pr14[4]||pr15[4])?({a42[4],a42[4],a42[4],a42[4],a42}):({4'b0000,a42});
    assign sh4=sea42<<2;      
    assign mux42= (mode1)?(sh4): (sea42);

    assign ps4=mux41+mux42;

// 8b x 8b computation

    assign merge={ps4,ps1[7:0]};
    assign a1=ps4+ps1;
    assign sea1=(ps4[7]||ps1[7])?({a1[7],a1[7],a1[7],a1[7],a1[7],a1[7],a1[7],a1[7],a1}):({8'b00000000,a1});
    assign mux1= (mode2)?(merge): (sea1);

    assign sea2=ps2+ps3;
    assign mux2= (mode2)?(shift): (sea2);

    always @(posedge clk)
    y=mux1+mux2;

    endmodule
   

   
    
