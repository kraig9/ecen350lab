`timescale 1ns / 1ps

module DataMemory(ReadData, Address, WriteData, MemoryRead, MemoryWrite, Clock); 

	input[31:0] Address, WriteData;
	input MemoryRead, MemoryWrite, Clock; 
	output [31:0] ReadData; 
	
	reg [31:0] ReadData;
	reg [31:0] registers [63:0];
	
	always @(negedge Clock) begin 
		if(MemoryWrite && !MemoryRead)
			registers[Address>>2] <= #20 WriteData;
	end        
	
	always @(posedge Clock) begin
		if(MemoryRead && !MemoryWrite)
			ReadData <= #20 registers[Address>>2];
	end
	
endmodule