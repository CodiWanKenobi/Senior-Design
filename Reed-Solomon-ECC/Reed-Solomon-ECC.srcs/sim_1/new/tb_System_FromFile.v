`timescale 1ns / 1ps

/* Input File format:
 * First line is a two-bit binary string indicating test format: 
 *     00 for full test:     INPUT[0:43]->Encoder->(enc_out ^ ERROR_MASK[0:59])->Decoder->output
 *        - Test passed if ((output == input) ? valid : ~valid) evaluates to true
 *     01 for decoder test:  ENCODED_DATA[0:59]->Decoder->out, compare with EXPECTED[0:43]
 *        - Test passed if ((output == EXPECTED) ? valid : ~valid) evaluates to true
 *     10 for syndrome test: MASKED_ENCODED_DATA[0:59]->Syndrome Generator->syndrome_out, compare with EXPECTED[0:16]
 *        - Test passed if (syndrome_out == EXPECTED) evaluates to true
 *
 * Subsequent lines in the input file are the hex strings to pass as the value for the all-caps values 
 * for each test, in the order they appear.
 *
 * Sample input for full test:
 * 00
 * 123456789AB
 * 000000000000000
 * 123456789AB
 * 000000000010000
 * ba987654321
 * 00000000000000F
 * 13579B2468A
 * 003000000000500
 * 2468A13579B
 * 00080000C00000F
 *
 * Sample input for decoder test:
 * 01
 * BA996654321C581
 * BA996654321
 *
 * Sample input for syndrome test:
 * 10
 * BA996654321C581
 * 9D90
 *
 * Note that the input file directory may need to be modified.
 * Default input path points to ...\Reed-Solomon-ECC\Reed-Solomon-ECC.sim\sim_1\behav\xsim\RS_Input.txt
 * Default output path points to ...\Reed-Solomon-ECC\Reed-Solomon-ECC.sim\sim_1\behav\xsim\Output_Data.txt
 */
module tb_System_FromFile();

    reg [1:0]  test_mode;
    reg [0:15] expected_syndrome;
    reg [0:43] data_in;
    reg [0:59] encoded_in;
    reg [0:59] error_mask;
    reg [0:43] expected_out;
    
    wire [0:59] encoded_out;
    wire [0:43] data_out;
    wire [0:15] syndrome_out;
    wire valid;
    
    RS_Debug sut(test_mode, data_in, encoded_in, error_mask, encoded_out, data_out, syndrome_out, valid);
    
        
    integer outFile,inFile,tc;

    initial begin
        tc = 0;
        test_mode = 0;
        expected_syndrome = 0;
        data_in = 0;
        encoded_in = 0;
        error_mask = 0;
        outFile = $fopen("Output_Data.txt", "w"); // Change path to where you want output file 
        inFile = $fopen("RS_Input.txt", "r");
        #50;
        $fscanf(inFile, "%b", test_mode);
        #50;
        while (! $feof(inFile)) begin           //run until reaching end of file
            $fwrite(outFile, "Test Case %0d:\n", tc);
            case (test_mode)
                0: begin
                    $fscanf(inFile, "%h", data_in);  //read in a line of the text file
                    $fscanf(inFile, "%h", error_mask);  //read in a line of the text file
                    #10;
                    $fwrite(outFile, "\tInput data: %h\n",     data_in);
                    $fwrite(outFile, "\tEncoded data: %h\n",   encoded_out);
                    $fwrite(outFile, "\tError mask: %h\n",     error_mask); 
                    $fwrite(outFile, "\tCorrected data: %h\n", data_out);
                    if (data_in == data_out ? valid : ~valid) begin
                        $fwrite(outFile, "Test Case %0d PASS\n\n", tc); 
                    end
                    else begin
                        $fwrite(outFile, "Test Case %0d FAIL\n\n", tc);
                    end
                end
                1: begin
                    $fscanf(inFile, "%h", encoded_in);  //read in a line of the text file
                    $fscanf(inFile, "%h", expected_out);
                    #10;
                    $fwrite(outFile, "\tEncoded data: %h\n",    encoded_in);
                    $fwrite(outFile, "\tExpected output: %h\n", expected_out);
                    $fwrite(outFile, "\tOutput data: %h\n",     data_out);
                    if (expected_out == data_out ? valid : ~valid)
                        $fwrite(outFile, "Test Case %0d PASS\n\n", tc);
                    else
                        $fwrite(outFile, "Test Case %0d FAIL\n\n", tc);
                end
                2: begin
                    $fscanf(inFile, "%h", encoded_in);  //read in a line of the text file
                    $fscanf(inFile, "%h", expected_syndrome);
                    #10;
                    $fwrite(outFile, "\tEncoded data: %h\n",      encoded_in);
                    $fwrite(outFile, "\tExpected syndrome: %h\n", expected_syndrome);
                    $fwrite(outFile, "\tSyndrome: %h\n",          syndrome_out);
                    if (syndrome_out == expected_syndrome)
                        $fwrite(outFile, "Test Case %0d PASS\n\n", tc);
                    else
                        $fwrite(outFile, "Test Case %0d FAIL\n\n", tc);
                end
            endcase
            tc = tc + 1;
        end
        $fclose(inFile);
        $fclose(outFile);
        #50;
        $finish;
        
    end
endmodule
