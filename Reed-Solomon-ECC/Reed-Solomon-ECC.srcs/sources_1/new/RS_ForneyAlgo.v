`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Zach Zipper
// 
// Create Date: 03/28/2021 12:39:34 PM
// Design Name: 
// Module Name: RS_ForneyAlgo
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


module RS_ForneyAlgo(
    input [0:11] lambda,
    input [0:7] omega,
    input [0:14] X,
    output [0:59] Y
    );
    
    //Note: Lambda prime is just the first degree term of lambda (lambda[4:7])
    reg [0:7] power;
    reg [0:15] Xi_inv;
    reg [0:59] Ybuf1, Ybuf2;
    reg [0:11] pos;
    
    wire [0:7] omegaEval;
    wire [0:7] numerator;
    wire [0:7] magnitude;
    GF_Poly_Evaluate2 pe0(omega, Xi_inv[0:7], omegaEval[0:3]);
    GF_Poly_Evaluate2 pe1(omega, Xi_inv[8:15], omegaEval[4:7]);
    GF_Multiply m0(power[0:3], omegaEval[0:3], numerator[0:3]);
    GF_Multiply m1(power[4:7], omegaEval[4:7], numerator[4:7]);  
    GF_Divide d0(numerator[0:3], lambda[4:7], magnitude[0:3]);
    GF_Divide d1(numerator[4:7], lambda[4:7], magnitude[4:7]);
    
    always @(*) begin
        Xi_inv = 0;
        power = 0;
        pos = 0;
        Ybuf1 = 0;
        Ybuf2 = 0;        
        
        //Degree 14
        if (X[0]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h21;
            power[0:3] = 4'h9;
            pos[0:5] = 0;
        
        //Degree 13
        end if (X[1]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h41;
            power[0:3] = 4'hD;
            pos[0:5] = 4; 
            
        //Degree 12
        end if (X[2]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h81;
            power[0:3] = 4'hF;
            pos[0:5] = 8;
            
        //Degree 11
        end if (X[3]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h31;
            power[0:3] = 4'hE;
            pos[0:5] = 12;            
            
        //Degree 10
        end if (X[4]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h61;
            power[0:3] = 4'h7;
            pos[0:5] = 16;            
            
        //Degree 09
        end if (X[5]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'hC1;
            power[0:3] = 4'hA;
            pos[0:5] = 20;
                        
        //Degree 08
        end if (X[6]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'hB1;
            power[0:3] = 4'h5;
            pos[0:5] = 24;
                        
        //Degree 07
        end if (X[7]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h51;
            power[0:3] = 4'hB;
            pos[0:5] = 28;
                       
        //Degree 06
        end if (X[8]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'hA1;
            power[0:3] = 4'hC;
            pos[0:5] = 32;
                       
        //Degree 05
        end if (X[9]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h71;
            power[0:3] = 4'h6;
            pos = 36;
                        
        //Degree 04
        end if (X[10]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'hE1;
            power[0:3] = 4'h3;
            pos[0:5] = 40;
                        
        //Degree 03
        end if (X[11]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'hF1;
            power[0:3] = 4'h8;
            pos[0:5] = 44;
                       
        //Degree 02
        end if (X[12]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'hD1;
            power[0:3] = 4'h4;
            pos[0:5] = 48;
                       
        //Degree 01
        end if (X[13]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h91;
            power[0:3] = 4'h2;
            pos[0:5] = 52;
                        
        //Degree 00
        end if (X[14]) begin
            Xi_inv = Xi_inv >> 8;
            power = power >> 4;
            pos = pos >> 6;
            Xi_inv[0:7] = 8'h11;
            power[0:3] = 4'h1;
            pos[0:5] = 56; 
        end 
        
        Ybuf1[0:3] = magnitude[0:3];
        Ybuf1 = Ybuf1 >> pos[0:5];
        
        Ybuf2[0:3] = magnitude[4:7];
        Ybuf2 = Ybuf2 >> pos[6:11];
    end
    
    assign Y = Ybuf1 | Ybuf2;
    
endmodule
