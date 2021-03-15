`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2021 12:05:10 AM
// Design Name: 
// Module Name: RS_Encoder
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


module RS_Encoder(
    input [0:43] in,
    output [0:59] out
    );
    
    // Code generating polynomial: g(x) = x^4 + 15x^3 + 3x^2 + x + 12 -> {1,15,3,1,12}
    wire [0:15] R;
    RS_Poly_Divide_CGP remainder(in, R);
    
    assign out = {in, R};
    
endmodule
