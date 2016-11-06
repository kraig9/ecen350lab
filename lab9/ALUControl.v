`timescale 1ns / 1ps
module ALUControl (ALUCtrl, ALUop, FuncCode);
	input [3:0] ALUop; //4 bits input
	input [5:0] FuncCode; //6 bits input
	output reg [3:0] ALUCtrl; //4 bits output
	
always @ (*)
begin
if(ALUop==4'b1111) //for R-type instructions
	begin
 		case(FuncCode)
			6'b000000 :ALUCtrl <= #2 4'b0011; //SLL
			6'b000010 :ALUCtrl <= #2 4'b0100; //SRL
			6'b000011 :ALUCtrl <= #2 4'b1101; //SRA
			6'b100000 :ALUCtrl <= #2 4'b0010; //ADD
			6'b100010 :ALUCtrl <= #2 4'b0110; //SUB
			6'b100100 :ALUCtrl <= #2 4'b0000; //AND
			6'b100101 :ALUCtrl <= #2 4'b0001; //OR
			6'b101010 :ALUCtrl <= #2 4'b0111; //SLT
		endcase
	end
else begin
	ALUCtrl <= #2 ALUop; end//for I-type instructions
	
end
endmodule
