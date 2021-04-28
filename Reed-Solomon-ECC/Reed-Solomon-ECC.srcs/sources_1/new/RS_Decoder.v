`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2021 01:57:11 PM
// Design Name: 
// Module Name: RS_Decoder
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


module RS_Decoder(
    input  [0:59] msg,
    output [0:43] decoded,
    output valid
    );
    
    wire [0:59] buffer;
    wire [0:59] Y;
    wire [0:15] syndrome, check_syndrome;
    wire [0:14] X;
    wire [0:11] lambda;
    wire [0:7]  omega;
    
    // Generate syndrome for encoded message
    RS_Syndrome syn(msg, syndrome);
    
    // Generate error locator polynomial
    RS_BM lamb(syndrome, lambda, omega);
    
    // Find roots of error locator polynomial
    RS_ChienSearch chien(lambda, X);
    
    // Calculate error values
    RS_Forney forney(lambda, omega, X, Y);
    
    // Correct errors
    GF_PolyAdd #(60) padd(msg, Y, buffer);
    
    // Generate syndrome for output to check if message was properly corrected
    RS_Syndrome check(buffer, check_syndrome);
    
    assign decoded = (|syndrome) ? buffer[0:43] : msg[0:43];
    assign valid = (|syndrome) ? ~(|check_syndrome) : 1'b1;
endmodule
