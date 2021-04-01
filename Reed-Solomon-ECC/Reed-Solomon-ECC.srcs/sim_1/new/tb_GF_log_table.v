`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2021 11:41:49 AM
// Design Name: 
// Module Name: tb_GF_log_table
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


module tb_GF_log_table();

    reg [0:3] in;
    reg [0:3] correct;
    wire [0:3] out;
    
    GF_log_table sut(in, out);
    
    initial begin
        in = 4'b0000;
        correct = 4'b0000;
        #50;
        in = 4'b0001;
        #50;
        in = 4'b0010;
        correct = 4'b0001;
        #50;
        in = 4'b0011;
        correct = 4'b0100;
        #50;
        in = 4'b0100;
        correct = 4'b0010;
        #50;
        in = 4'b0101;
        correct = 4'b1000;
        #50;
        in = 4'b0110;
        correct = 4'b0101;
        #50;
        in = 4'b0111;
        correct = 4'b1010;
        #50;
        in = 4'b1000;
        correct = 4'b0011;
        #50;
        in = 4'b1001;
        correct = 4'b1110;
        #50;
        in = 4'b1010;
        correct = 4'b1001;
        #50;
        in = 4'b1011;
        correct = 4'b0111;
        #50;
        in = 4'b1100;
        correct = 4'b0110;
        #50;
        in = 4'b1101;
        correct = 4'b1101;
        #50;
        in = 4'b1110;
        correct = 4'b1011;
        #50;
        in = 4'b1111;
        correct = 4'b1100;
        #50;
    end
endmodule
