`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2021 03:15:40 PM
// Design Name: 
// Module Name: tb_System_FromFile
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


module tb_System_FromFile();

    reg [0:43] in_data;
    reg [0:59] error_mask;
    wire [0:59] encoded_data;
    reg [0:59] modified_data;
    wire [0:43] out_data;
    wire valid;
    
    RS_Encoder rse(in_data,encoded_data);
    RS_Decoder rsd(modified_data,out_data,valid);
    
        
    integer outFile,inFile;

    initial begin
        outFile = $fopen("C:\\Mihir\\out.txt", "w"); //change path to where you want output file 
        inFile = $fopen("data.txt", "r");
        
        while (! $feof(inFile)) begin           //run until reaching end of file
            $fscanf(inFile, "%h", in_data);  //read in a line of the text file
            $fscanf(inFile, "%h", error_mask);  //read in a line of the text file
//            $ferror(inFile,str);
//            $display("%s",str);
            #50
            modified_data = encoded_data ^ error_mask;
            #50;
            $fwrite(outFile, "Input data: %h\n", in_data);   //write data 
            $fwrite(outFile, "Encoded data: %h\n", encoded_data);   //write data 
            $fwrite(outFile, "Error mask: %h\n", error_mask);   //write data 
            $fwrite(outFile, "Corrected data: %h\n", out_data);   //write data 
            if (in_data == out_data ? valid : ~valid) begin
                $fwrite(outFile, "Success\n");   //write data 
            end 
            else begin
                $fwrite(outFile, "Failure\n");   //write data 
            end
            //$fflush(outFile);
            
            #50;
        end
        $fclose(outFile);
        #50;
        $finish;
        
    end
endmodule
