`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2025 23:56:49
// Design Name: 
// Module Name: tb_4bit
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


module tb_4bit;

reg signed [31:0]a,b;
reg [3:0]sx1,sx2,sx3,sx4,sy1,sy2,sy3,sy4;
reg mode1,mode2,clk=1'b0;
wire signed [15:0]y;



always 
#2 clk=~clk;
    
    reg signed [15:0] expected_result;  // Expected signed result

    // Instantiate the DUT 
    OAFU uut(a,b,sx1,sx2,sx3,sx4,sy1,sy2,sy3,sy4,mode1,mode2,clk,y);
    integer file;
    reg [16:0] i, j;  // Use 8-bit registers instead of integers
    reg signed [3:0] c1,c2,c3,c4,d1,d2,d3,d4;
    reg signed [15:0] x1,y1;
    initial begin
        // Open a file to save results
        file = $fopen("psmac_4bit_mode_part1.csv", "w");
        $fdisplay(file, "c1,d1,c2,d2,c3,d3,c4,d4,Result,Expected_Result,Status");  // CSV header

        // Iterate over all 8-bit input combinations
        for (i = 17'd0; i < 17'b00000000011111111; i = i + 1) begin
            for (j = 17'd0; j < 17'b01111000000001111; j = j + 1) begin
                a = {i[15:12],i[15:12],i[11:8],i[11:8],i[7:4],i[7:4],i[3:0],i[3:0]};
                b = {j[15:14],j[15:14],j[13:12],j[13:12],j[11:10],j[11:10],j[9:8],j[9:8],j[7:6],j[7:6],j[5:4],j[5:4],j[3:2],j[3:2],j[1:0],j[1:0]};
                sx1=4'ha;sx2=4'ha;sx3=4'ha;sx4=4'ha;sy1=4'hc;sy2=4'hc;sy3=4'hc;sy4=4'hc;mode1=1'b1;mode2=1'b0;
                c1 = i[15:12]; d1=j[15:12];
                c2 = i[11:8]; d2=j[11:8];
                c3 = i[7:4]; d3=j[7:4];
                c4 = i[3:0]; d4=j[3:0];
                x1 = i[15:0]; y1 = j[15:0];
                expected_result = ($signed(c1) * $signed(d1))+($signed(c2) * $signed(d2))+($signed(c3) * $signed(d3))+($signed(c4) * $signed(d4));
                #10;  // Wait for the computation
                
                if (y == expected_result) 
                    $fdisplay(file, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,Pass", c1, d1,c2,d2,c3,d3,c4,d4, y, expected_result);
                else 
                    $fdisplay(file, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,Fail", c1, d1,c2,d2,c3,d3,c4,d4, y, expected_result);
            end
        end

        $fclose(file);
        $stop;
    end
    
endmodule