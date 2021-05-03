`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2021 07:50:12 PM
// Design Name: 
// Module Name: RS_Top
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


module RS_Top(
    input [0:43] in,
    input [0:59] mask,
    output [0:43] decoded,
    output valid
    );
    
    wire [0:59] masked;
    wire [0:59] encoded;
    
    RS_Encoder(in, encoded);
    assign masked = encoded ^ mask;
    RS_Decoder(masked, decoded, valid);
    
endmodule
