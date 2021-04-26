`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 11:27:33 PM
// Design Name: 
// Module Name: GF_Pow
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


module GF_Pow(
    input [0:3] A,
    input [0:3] B,
    output reg [0:3] out
    );
    
    wire [0:3]logA;
    GF_log_table log1(A[0:3], logA);
    
    wire [0:4]multiplied;
    wire [0:3]product;
    
    assign multiplied = logA * B;
    
    GF_exp_table exp1(multiplied,product); 
    
    always @ (*)
    begin
        if(|A == 0)     // 0^0 will return 0 (0^0 is one of seven indeterminate forms)
            out = 4'h0;
        else if(|B == 0)
            out = 4'h1;
        else
            out = product;
    end
endmodule
