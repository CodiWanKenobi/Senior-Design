`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Zach Zipper
// 
// Create Date: 03/28/2021 12:39:34 PM
// Design Name: 
// Module Name: RS_NewForney
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


module RS_NewForney(
    input [0:11] lambda,
    input [0:7] omega,
    input [0:14] X,
    output [0:59] Y
    );
    
    wire [0:7]  power;
    wire [0:15] Xi_inv;
    wire [0:11] pos;
    wire [0:59] Ybuf1, Ybuf2;
    
    wire [0:7]  omegaEval;
    wire [0:7]  numerator;
    wire [0:7]  magnitude;
    
    wire [0:7]  pows      [14:0];
    wire [0:11] positions [14:0];
    wire [0:15] Xi_invs   [14:0];
    
    GF_Poly_Evaluate2 pe0(omega, Xi_inv[0:7], omegaEval[0:3]);
    GF_Poly_Evaluate2 pe1(omega, Xi_inv[8:15], omegaEval[4:7]);

    GF_Multiply m0(numerator[0:3], omegaEval[0:3], magnitude[0:3]);
    GF_Multiply m1(numerator[4:7], omegaEval[4:7], magnitude[4:7]);  

    GF_Divide d0(power[0:3], lambda[4:7], numerator[0:3]);
    GF_Divide d1(power[4:7], lambda[4:7], numerator[4:7]);
    
    RS_ForneyModule x0(
        .X(X[0]),
        .pow(8'h0),
        .position(12'h0),
        .Xi_inverse(16'h0),
        .new_pow(4'h8),
        .new_pos(6'h0),
        .new_Xi(8'h21),
        
        .pow_out(pows[0]),
        .pos_out(positions[0]),
        .Xi_inv_out(Xi_invs[0])
    );
    
    RS_ForneyModule x1(
        .X(X[1]),
        .pow(pows[0]),
        .position(positions[0]),
        .Xi_inverse(Xi_invs[0]),
        .new_pow(4'hC),
        .new_pos(6'h4),
        .new_Xi(8'h41),
        
        .pow_out(pows[1]),
        .pos_out(positions[1]),
        .Xi_inv_out(Xi_invs[1])
    );
    
    RS_ForneyModule x2(
        .X(X[2]),
        .pow(pows[1]),
        .position(positions[1]),
        .Xi_inverse(Xi_invs[1]),
        .new_pow(4'hA),
        .new_pos(6'h8),
        .new_Xi(8'h81),
        
        .pow_out(pows[2]),
        .pos_out(positions[2]),
        .Xi_inv_out(Xi_invs[2])
    );
    
    RS_ForneyModule x3(
        .X(X[3]),
        .pow(pows[2]),
        .position(positions[2]),
        .Xi_inverse(Xi_invs[2]),
        .new_pow(4'hF),
        .new_pos(6'hC),
        .new_Xi(8'h31),
        
        .pow_out(pows[3]),
        .pos_out(positions[3]),
        .Xi_inv_out(Xi_invs[3])
    );
    
    RS_ForneyModule x4(
        .X(X[4]),
        .pow(pows[3]),
        .position(positions[3]),
        .Xi_inverse(Xi_invs[3]),
        .new_pow(4'h1),
        .new_pos(6'h10),
        .new_Xi(8'h61),
        
        .pow_out(pows[4]),
        .pos_out(positions[4]),
        .Xi_inv_out(Xi_invs[4])
    );
    
    RS_ForneyModule x5(
        .X(X[5]),
        .pow(pows[4]),
        .position(positions[4]),
        .Xi_inverse(Xi_invs[4]),
        .new_pow(4'h8),
        .new_pos(6'h14),
        .new_Xi(8'hC1),
        
        .pow_out(pows[5]),
        .pos_out(positions[5]),
        .Xi_inv_out(Xi_invs[5])
    );
    
    RS_ForneyModule x6(
        .X(X[6]),
        .pow(pows[5]),
        .position(positions[5]),
        .Xi_inverse(Xi_invs[5]),
        .new_pow(4'hC),
        .new_pos(6'h18),
        .new_Xi(8'hB1),
        
        .pow_out(pows[6]),
        .pos_out(positions[6]),
        .Xi_inv_out(Xi_invs[6])
    );
    
    RS_ForneyModule x7(
        .X(X[7]),
        .pow(pows[6]),
        .position(positions[6]),
        .Xi_inverse(Xi_invs[6]),
        .new_pow(4'hA),
        .new_pos(6'h1C),
        .new_Xi(8'h51),
        
        .pow_out(pows[7]),
        .pos_out(positions[7]),
        .Xi_inv_out(Xi_invs[7])
    );
    
    RS_ForneyModule x8(
        .X(X[8]),
        .pow(pows[7]),
        .position(positions[7]),
        .Xi_inverse(Xi_invs[7]),
        .new_pow(4'hF),
        .new_pos(6'h20),
        .new_Xi(8'hA1),
        
        .pow_out(pows[8]),
        .pos_out(positions[8]),
        .Xi_inv_out(Xi_invs[8])
    );
    
    RS_ForneyModule x9(
        .X(X[9]),
        .pow(pows[8]),
        .position(positions[8]),
        .Xi_inverse(Xi_invs[8]),
        .new_pow(4'h1),
        .new_pos(6'h24),
        .new_Xi(8'h71),
        
        .pow_out(pows[9]),
        .pos_out(positions[9]),
        .Xi_inv_out(Xi_invs[9])
    );
    
    RS_ForneyModule x10(
        .X(X[10]),
        .pow(pows[9]),
        .position(positions[9]),
        .Xi_inverse(Xi_invs[9]),
        .new_pow(4'h8),
        .new_pos(6'h28),
        .new_Xi(8'hE1),
        
        .pow_out(pows[10]),
        .pos_out(positions[10]),
        .Xi_inv_out(Xi_invs[10])
    );
    
    RS_ForneyModule x11(
        .X(X[11]),
        .pow(pows[10]),
        .position(positions[10]),
        .Xi_inverse(Xi_invs[10]),
        .new_pow(4'hC),
        .new_pos(6'h2C),
        .new_Xi(8'hF1),
        
        .pow_out(pows[11]),
        .pos_out(positions[11]),
        .Xi_inv_out(Xi_invs[11])
    );
    
    RS_ForneyModule x12(
        .X(X[12]),
        .pow(pows[11]),
        .position(positions[11]),
        .Xi_inverse(Xi_invs[11]),
        .new_pow(4'hA),
        .new_pos(6'h30),
        .new_Xi(8'hD1),
        
        .pow_out(pows[12]),
        .pos_out(positions[12]),
        .Xi_inv_out(Xi_invs[12])
    );
    
    RS_ForneyModule x13(
        .X(X[13]),
        .pow(pows[12]),
        .position(positions[12]),
        .Xi_inverse(Xi_invs[12]),
        .new_pow(4'hF),
        .new_pos(6'h34),
        .new_Xi(8'h91),
        
        .pow_out(pows[13]),
        .pos_out(positions[13]),
        .Xi_inv_out(Xi_invs[13])
    );
    
    RS_ForneyModule x14(
        .X(X[14]),
        .pow(pows[13]),
        .position(positions[13]),
        .Xi_inverse(Xi_invs[13]),
        .new_pow(4'h1),
        .new_pos(6'h38),
        .new_Xi(8'h11),
        
        .pow_out(power),
        .pos_out(pos),
        .Xi_inv_out(Xi_inv)
    );
    
    assign Ybuf1 = {magnitude[0:3], 56'h0};
    assign Ybuf2 = {magnitude[4:7], 56'h0};
    assign Y = (Ybuf1 >> pos[0:5]) | (Ybuf2 >> pos[6:11]);
endmodule

module RS_ForneyModule(
    input X,
    input [0:11] position,
    input [0:15] Xi_inverse,
    input [0:7]  pow,
    input [0:5]  new_pos,
    input [0:7]  new_Xi,
    input [0:3]  new_pow,
    
    output [0:7] pow_out,
    output [0:11] pos_out,
    output [0:15] Xi_inv_out
    );

    wire [0:7]  pow_new;
    wire [0:11] pos_new;
    wire [0:15] Xi_inv_new;
    
    assign pow_out    = X ? {new_pow, pow[0:3]}        : pow;
    assign pos_out    = X ? {new_pos, position[0:5]}   : position;
    assign Xi_inv_out = X ? {new_Xi,  Xi_inverse[0:7]} : Xi_inverse;
endmodule
