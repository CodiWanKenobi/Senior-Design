`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Carter Milch
// 
// Create Date: 03/26/2021 02:38:14 PM
// Design Name: 
// Module Name: GF_PolyScale
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Galois Field Polynomial scale operation.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GF_PolyScale #(parameter SIZE=20)(
    input [0:SIZE-1] poly,
    input [0:3] scalar,
    output [0:SIZE-1] scaled
    );
    
    genvar i;
    generate
        for (i = 0; i < (SIZE >> 2); i = i + 1) begin
            GF_Multiply mult(poly[(i << 2) : (i << 2) + 3], scalar, scaled[(i << 2) : (i << 2) + 3]);
        end
    endgenerate
endmodule
