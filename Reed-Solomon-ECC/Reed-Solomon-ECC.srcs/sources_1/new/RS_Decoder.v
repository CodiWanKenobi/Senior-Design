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
    input [0:59] msg,
    output reg [0:43] decoded
    );
    wire [0:15] syndrome;
    wire [0:11] lambda;
    wire [0:7] omega;
    wire [0:14] X;
    wire [0:59] Y;
    wire [0:59] buffer;
    
    RS_Syndrome syn(msg, syndrome);
    RS_BM_Fast lamb(syndrome, lambda);
    RS_ChienSearch chien(lambda, X);
    RS_CalcOmega omeg(syndrome, lambda, omega);
    RS_ForneyAlgo forney(lambda, omega, X, Y);
    GF_PolyAdd #(60) padd(msg, Y, buffer);
    
    always@(*) begin
        if(syndrome)
            decoded = buffer[0:43];
        else
            decoded = msg[0:43];
    end
    
endmodule
