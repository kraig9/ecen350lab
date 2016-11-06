`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump);
input [31:0] CurrentPC, SignExtImm32;
input [25:0] JumpField;
input Branch, ALUZero, Jump;
output [31:0] NextPC;
reg [31:0] NextPC;
reg [31:0] PC;



always@(Branch or ALUZero or Jump or CurrentPC)
if(Branch && ALUZero)
	begin
	NextPC <= #3 $signed(SignExtImm32<<2) + CurrentPC + 4; 
	end
else
if(Jump)
	begin
	assign PC =(CurrentPC + 4);
	NextPC <= #3{PC[31:28], JumpField, 2'b00};
	end
else
	begin
	NextPC <= #2 CurrentPC + 4;
	end 
	
endmodule