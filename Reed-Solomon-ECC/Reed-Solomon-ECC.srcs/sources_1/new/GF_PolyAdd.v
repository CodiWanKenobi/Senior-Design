`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Carter Milch
// 
// Create Date: 03/26/2021 03:05:51 PM
// Design Name: 
// Module Name: GF_PolyAdd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Galois Field Polynomial Addition.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GF_PolyAdd #(parameter SIZE=20)(
    input [0:SIZE-1] a, // Lowest degree term should be at least-significant bits for a and b
    input [0:SIZE-1] b,
    output [0:SIZE-1] sum
    );
    
    assign sum = a ^ b;
    
endmodule
