`timescale 1ns / 1ps

module DataMemory(ReadData, Address, WriteData, MemoryRead, MemoryWrite, Clock); //module starts...

	input[31:0] Address, WriteData; //32 bits inputs
	input MemoryRead, MemoryWrite, Clock; //control signals
	output [31:0] ReadData; //32 bits outputs
	
	reg [31:0] ReadData; //temporary register
	reg [31:0] registers [63:0]; //simulated data memory
	
	always @(negedge Clock) begin //write function
		if(MemoryWrite && !MemoryRead)
			registers[Address>>2] <= #20 WriteData; //write when negative clock edge and MemoryWrite = 1
	end        
	
	always @(posedge Clock) begin //read function
		if(MemoryRead && !MemoryWrite)
			ReadData <= #20 registers[Address>>2]; //read when positive clock edge and MemoryRead = 1
	end
	
endmodule //ends...