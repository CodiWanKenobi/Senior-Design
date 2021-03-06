`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 11:10:19 AM
// Design Name: 
// Module Name: GF_Poly_Evaluate
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

//Evalute a polynomial with 2 coefficients
//And last coefficient is a 1
module GF_Poly_Evaluate2(
    input [0:7] coef,
    input [0:7] values,
    output [0:3] out
    );
    
    wire [0:3]m0;
    GF_Multiply mult0(coef[0:3],values[0:3],m0);
    assign out = m0 ^ coef[4:7];    

endmodule
