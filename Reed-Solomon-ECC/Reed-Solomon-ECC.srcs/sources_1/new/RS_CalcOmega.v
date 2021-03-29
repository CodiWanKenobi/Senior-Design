`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Zach Zipper
// 
// Create Date: 03/28/2021 11:20:21 AM
// Design Name: 
// Module Name: RS_CalcOmega
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

//takes 4 coefficient syndrome and 3 coefficient lambda as input
//produces 2 coefficient omega as output
module RS_CalcOmega(
    input [0:15] syndrome,
    input [0:11] lambda,
    output reg [0:7] omega
    );
    wire [0:3] o1;
    wire [0:3] o2;
    wire [0:3] o0;
    
    GF_Multiply m0(syndrome[12:15], lambda[8:11], o0); 
    GF_Multiply m1(syndrome[8:11], lambda[8:11], o1); 
    GF_Multiply m2(syndrome[12:15], lambda[4:7], o2);  
    always @(*) begin
        omega[4:7] = o0;
        if (lambda[0] | lambda[1] | lambda[2] | lambda[3]) begin
            omega[0:3] = o1 ^ o2;
        end else begin
            omega[0:3] = 0; 
        end
    end
    
endmodule
