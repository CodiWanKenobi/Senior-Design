`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2021 04:33:18 PM
// Design Name: 
// Module Name: tb_RS_Encoder
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


module tb_RS_Encoder();

reg [0:43] A;
    
    wire [0:59] out;
    
    RS_Encoder_Optimized encoder(A,out);
    
    initial begin
//        A = {4'h1,4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'h8,4'h9,4'hA,4'hB};
        A = 44'h123456789AB;
        #50;
        $display("TC01");
        if(out != 60'h123456789AB33cc) $display ("Result is wrong.");
        
        A = 44'hBA987654321;
        #50;
        $display("TC02");
        if(out != 60'hBA987654321C581) $display ("Result is wrong.");
        
        A = 44'hda501a98630;
        #50;
        $display("TC03");
        if(out != 60'hda501a98630c809) $display ("Result is wrong.");
        
        A = 44'h5b9128d3ff0;
        #50;
        $display("TC04");
        if(out != 60'h5b9128d3ff08b32) $display ("Result is wrong.");
        
       
    end

endmodule
