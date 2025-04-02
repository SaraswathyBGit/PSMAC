`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2025 20:42:55
// Design Name: 
// Module Name: tb_8bit
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


module tb_8bit;

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
    reg [8:0] i, j;  // Use 8-bit registers instead of integers
    reg signed [7:0] c,d;
    initial begin
        // Open a file to save results
        file = $fopen("psmac_8bit_mode_new.csv", "w");
        $fdisplay(file, "A,B,Result,Expected_Result,Status");  // CSV header

        // Iterate over all 8-bit input combinations
        for (i = 9'd0; i < 9'b100000000; i = i + 1) begin
            for (j = 9'd0; j < 9'b100000000; j = j + 1) begin
                a = {i[7:4],i[7:4],i[3:0],i[3:0],i[7:4],i[7:4],i[3:0],i[3:0]};
                b = {j[7:6],j[7:6],j[5:4],j[5:4],j[7:6],j[7:6],j[5:4],j[5:4],j[3:2],j[3:2],j[1:0],j[1:0],j[3:2],j[3:2],j[1:0],j[1:0]};
                sx1=4'h0;sx2=4'ha;sx3=4'h0;sx4=4'ha;sy1=4'h0;sy2=4'h0;sy3=4'hc;sy4=4'hc;mode1=1'b1;mode2=1'b1;
                c = i[7:0]; d=j[7:0];
                expected_result = $signed(c) * $signed(d);
                #10;  // Wait for the computation
                
                if (y == expected_result) 
                    $fdisplay(file, "%d,%d,%d,%d,Pass", c, d, y, expected_result);
                else 
                    $fdisplay(file, "%d,%d,%d,%d,Fail", c, d, y, expected_result);
            end
        end

        $fclose(file);
        $stop;
    end
    
endmodule