 `timescale 1ns / 1ps
`define STRLEN 15

module SignExtenderTest;

	task passTest;
		input [31:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end	//pass/fail conditional
		else $display ("%s failed: %b should be %b", testType, actualOut, expectedOut);		//Write test results to screen
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	// Inputs
	reg [15:0] Imm16;
	reg Ctrl;
	reg [7:0] passed;

	// 32 bit output
	wire [31:0] BusImm;

	// Instantiate the Unit Under Test (UUT)
	SignExtender uut (
		.BusImm(BusImm), 
		.Imm16(Imm16), 
		.Ctrl(Ctrl) 
	        );

   initial begin
	$dumpfile("SignExtender.vcd");
    $dumpvars(0,SignExtenderTest);
      // Initialize Inputs
      Imm16 = 16'b0000000000000000;
      Ctrl = 0;
	  passed = 0;

      // Add stimulus here
      #90; Imm16=16'b1000000100000001;Ctrl=1; #10; passTest({BusImm}, 32'b00000000000000001000000100000001, "0 extend", passed);	//Check for adding 0s
      #90; Imm16=16'b1000000100000001;Ctrl=0; #10; passTest({BusImm}, 32'b11111111111111111000000100000001, "sign extend", passed);	//check for sign extending
	  #90; Imm16=16'b1111111111111111;Ctrl=1; #10; passTest({BusImm}, 32'b00000000000000001111111111111111, "0 extend", passed);	
      #90; Imm16=16'b0000000000000000;Ctrl=0; #10; passTest({BusImm}, 32'b00000000000000000000000000000000, "sign extend", passed);
	  #90; Imm16=16'b0000000000000001;Ctrl=1; #10; passTest({BusImm}, 32'b00000000000000000000000000000001, "0 extend", passed);
	  #90; Imm16=16'b0000000000000001;Ctrl=0; #10; passTest({BusImm}, 32'b00000000000000000000000000000001, "sign extend", passed);
	  #90; Imm16=16'b1000000100000001;Ctrl=0; #10; passTest({BusImm}, 32'b11111111111111111000000100000001, "sign extend", passed);
	  #90; Imm16=16'b1000000100000001;Ctrl=1; #10; passTest({BusImm}, 32'b00000000000000001000000100000001, "0 extend", passed);	//waveform
      allPassed(passed, 8);

	end
endmodule