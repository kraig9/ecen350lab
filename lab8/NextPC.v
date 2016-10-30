`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump);
input [31:0] CurrentPC, SignExtImm32; //32 bits
input [25:0] JumpField; //26 bits
input Branch, ALUZero, Jump; //control signal
output [31:0] NextPC; //32 bits
reg [31:0] NextPC; //32-bit temporary register
reg [31:0] PC; //32-bit temporary register



always@(Branch or ALUZero or Jump or CurrentPC)
if(Branch && ALUZero)
	begin
	NextPC <= #3 $signed(SignExtImm32<<2) + CurrentPC + 4; //branch
	end
else
if(Jump)
	begin
	assign PC =(CurrentPC + 4);
	NextPC <= #3{PC[31:28], JumpField, 2'b00}; //jump: last 4 bits of PC + 26 bits of jump field + 00
	end
else
	begin
	NextPC <= #2 CurrentPC + 4; //normal
	end 
	
endmodule