`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Zach Zipper
// 
// Create Date: 02/26/2021 04:43:36 PM
// Design Name: 
// Module Name: GF_log_table
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Lookup table for taking the log of a GF element
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module GF_log_table(
    input [0:3] in,
    output [0:3] out
    );

    wire bit0,bit1,bit2,bit3;
        
    wire [0:3] in_not;
    assign in_not = ~in;
    
    
    // Wires for repeated terms
    wire b2_and_b3;
    and(b2_and_b3, in[2], in[3]);
    
    wire b2_and_nb3;
    and(b2_and_nb3, in[2], in_not[3]);
    
    wire nb2_and_b3;
    and(nb2_and_b3, in_not[2], in[3]);
    
    
    assign bit3 = b2_and_nb3 | 
                 (in[0] & ((in_not[1] & (in_not[3] | in[2])) | 
                 (in[1] & nb2_and_b3)));
          
    assign bit2 = (in[1] & ( (in_not[2] & in_not[3]) | (in[0] & in_not[3]) | (in_not[0] & b2_and_b3))) |
                  ((in_not[1] & in[0]) & (in_not[2] | in[3]));
                  
    assign bit1 = (in[0] & (in[3] | (in[1] & in_not[2]))) |
                  (in_not[0] & in[1] & b2_and_nb3) |
                  (in_not[1] & b2_and_b3);
                  
    assign bit0 = (in[0] & ( (nb2_and_b3) | (b2_and_nb3))) |
                  (in[1] & in[3]);
                  
    assign out = {bit0, bit1, bit2, bit3};
endmodule
