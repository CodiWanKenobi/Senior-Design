`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 11:44:36 PM
// Design Name: 
// Module Name: tb_GF_Pow
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


module tb_GF_Pow();

    reg [0:3] A;
    reg [0:3] B;
    
    wire [0:3] out;
    
    GF_Pow uut(
        .A(A),
        .B(B),
        .out(out)
    );
    
    initial begin
        A = 4'h0;
        B = 4'h0;
        #50;
        $display("TC01");
        if(out != 4'h0) $display ("Result is wrong.");
        
        A = 4'h0;
        B = 4'h1;
        #50;
        $display("TC02");
        if(out != 4'h0) $display ("Result is wrong.");
        
        A = 4'h1;
        B = 4'h0;
        #50;
        $display("TC02");
        if(out != 4'h1) $display ("Result is wrong.");
        
        A = 4'h1;
        B = 4'h2;
        #50;
        $display("TC03");
        if(out != 4'h1) $display ("Result is wrong.");
        
        A = 4'h2;
        B = 4'h3;
        #50;
        $display("TC04");
        if(out != 4'h8) $display ("Result is wrong.");
        
        A = 4'h3;
        B = 4'h3;
        #50;
        $display("TC05");
        if(out != 4'hF) $display ("Result is wrong.");
        
        A = 4'h4;
        B = 4'h2;
        #50;
        $display("TC06");
        if(out != 4'h3) $display ("Result is wrong.");
        
        // This test case doesn't work because a power over 31 is  not defined currently
        A = 4'h7;
        B = 4'hA;
        #50;
        $display("TC07");
        if(out != 4'h7) $display ("Result is wrong.");
        
        A = 4'hC;
        B = 4'h5;
        #50;
        $display("TC08");
        if(out != 4'h1) $display ("Result is wrong.");
    end
endmodule
