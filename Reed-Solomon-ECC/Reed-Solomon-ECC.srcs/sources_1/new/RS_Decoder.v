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
    wire [0:15] syndrome, syn2;
    wire [0:14] X;
    wire [0:59] Y;
    wire [0:59] buffer;
    wire [0:11] lambda;
    wire [0:7]  omega;
    
    RS_Syndrome syn(msg, syndrome);
    RS_BM_Fast lamb(syndrome, lambda, omega);
    RS_ChienSearch chien(lambda, X);
    //RS_CalcOmega omeg(syndrome, lambda, omega);
    RS_NewForney forney(lambda, omega, X, Y);
    GF_PolyAdd #(60) padd(msg, Y, buffer);
    RS_Syndrome check(buffer, syn2);
    
    assign decoded = (|syndrome) ? buffer[0:43] : msg[0:43];
    assign valid = (|syndrome) ? ~(|syn2) : 1'b1;
endmodule
