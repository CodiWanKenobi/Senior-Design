`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2021 04:39:28 PM
// Design Name: 
// Module Name: tb_RS_BMHelper
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


module tb_RS_BMHelper();
    
    reg [0:15] syndrome;
    wire [0:11] out;
    
    RS_BMHelper sut(syndrome, out);
    
    initial begin
        syndrome = 16'hC43F;
        #50;
        $display ("Test Case 01");
        if(out != 12'hEE1) $display ("Result is wrong.");
        #50;
        syndrome = 16'h0822;
        #50;
        $display ("Test Case 02");
        if(out != 12'hEA1) $display ("Result is wrong.");
        #50;
        syndrome = 16'hBF59;
        #50;
        $display ("Test Case 03");
        if(out != 12'h281) $display ("Result is wrong.");
        #50;
        syndrome = 16'hD174;
        #50;
        $display ("Test Case 04");
        if(out != 12'h231) $display ("Result is wrong.");
        #50;
        syndrome = 16'h0822;
        #50;
        $display ("Test Case 05");
        if(out != 12'hEA1) $display ("Result is wrong.");
        #50;
        syndrome = 16'h5FC6;
        #50;
        $display ("Test Case 06");
        if(out != 12'hF21) $display ("Result is wrong.");
        #50;
        syndrome = 16'h6F90;
        #50;
        $display ("Test Case 07");
        if(out != 12'h2D1) $display ("Result is wrong.");
        #50;
        syndrome = 16'h07C0;
        #50;
        $display ("Test Case 08");
        if(out != 12'h531) $display ("Result is wrong.");
        #50;
        syndrome = 16'hD062;
        #50;
        $display ("Test Case 09");
        if(out != 12'h531) $display ("Result is wrong.");
        #50;
        syndrome = 16'h2053;
        #50;
        $display ("Test Case 10");
        if(out != 12'h551) $display ("Result is wrong.");
        #50;
        syndrome = 16'h530E; //Delta1 == 0
        #50;
        $display ("Test Case 11");
        if(out != 12'h531) $display ("Result is wrong.");
        #50;
        syndrome = 16'hBD37; //Delta2 == 0
        #50;
        $display ("Test Case 12");
        if(out != 12'h0A1) $display ("Result is wrong.");
    end

endmodule
