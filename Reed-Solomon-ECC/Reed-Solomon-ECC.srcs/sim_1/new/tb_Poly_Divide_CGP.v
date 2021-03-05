`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2021 07:58:15 PM
// Design Name: 
// Module Name: tb_Poly_Divide_CGP
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


module tb_Poly_Divide_CGP();


    reg [0:43] A;
    
    wire [0:15] out;
    
    RS_Poly_Divide_CGP div(A,out);
    
    initial begin
//        A = {4'h1,4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'h8,4'h9,4'hA,4'hB};
        A = 44'h123456789AB;
        #50;
        $display("TC01");
        if(out != 16'h33cc) $display ("Result is wrong.");
        
        A = 44'hBA987654321;
        #50;
        $display("TC02");
        if(out != 16'hC581) $display ("Result is wrong.");
        
        A = 44'hda501a98630;
        #50;
        $display("TC03");
        if(out != 16'hc809) $display ("Result is wrong.");
        
        A = 44'h5b9128d3ff0;
        #50;
        $display("TC04");
        if(out != 16'h8b32) $display ("Result is wrong.");
        
       
    end
endmodule
