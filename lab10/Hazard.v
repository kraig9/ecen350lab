`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:22:52 04/11/2008 
// Design Name: 
// Module Name:    Hazard 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define NH 3'b000
`define Jump 3'b001
`define C1 3'b010
`define C2 3'b011
`define B 3'b100
`define B1 3'b101
`define B2 3'b110

module Hazard(PCWrite, IFWrite, Bubble, Branch, ALUZero4, Jump, rw, rs, rt, Reset_L, CLK);
	input			Branch;
	input			ALUZero4;
	input			Jump;
	input	[4:0]	rw;
	input	[4:0]	rs;
	input	[4:0]	rt;
	input			Reset_L;
	input			CLK;
	output		PCWrite;
	output		IFWrite;
	output		Bubble;
	
	reg [4:0] oldrw [2:0];
	wire comp1, comp2, comp3;
	reg Bubble;
	reg IFWrite;
	reg PCWrite;
	reg [2:0] CurState;
	reg [2:0] NextState;
	
	always@(negedge CLK or Reset_L) begin
		if(~Reset_L) begin
				CurState<= #2 `NH;
				NextState<= #2 `NH;
			end else begin
				CurState<= #2 NextState;
		end
	end

	always@(negedge CLK) begin
		oldrw[2]<= #1 oldrw[1];
		oldrw[1]<= #1 oldrw[0];
		oldrw[0]<= #1 rw;
	end
	
	assign comp1=(((oldrw[0]==rs) || (oldrw[0]==rt)) && oldrw[0] != 0)?1'b1:1'b0;
	assign comp2=(((oldrw[1]==rs) || (oldrw[1]==rt)) && oldrw[1] != 0)?1'b1:1'b0;
	assign comp3=(((oldrw[2]==rs) || (oldrw[2]==rt)) && oldrw[2] != 0)?1'b1:1'b0;
	
	always@(*) begin

		case(CurState)
			`Jump: begin
				NextState <= `NH;
				PCWrite <= 1'b1;
				IFWrite <= 1'b1;
				Bubble <= 1'b1;
			end
			
			`NH: begin
				if(Jump) begin
					NextState <= `Jump;
					PCWrite <= 1'b1;
					IFWrite <= 1'b0;
					Bubble <= 1'b0;
				end
				else if(comp1) begin
					NextState <= `C1;
					PCWrite <= 1'b0;
					IFWrite <= 1'b0;
					Bubble <= 1'b1;
				end
				else if(comp2) begin
					NextState <= `C2;
					PCWrite <= 1'b0;
					IFWrite <= 1'b0;
					Bubble <= 1'b1;
				end
				else if(comp3) begin
					NextState <= `NH;
					PCWrite <= 1'b0;
					IFWrite <= 1'b0;
					Bubble <= 1'b1;
				end
				else if(~Jump && ~Branch && ~comp1 && ~comp2 && ~comp3) begin
					NextState <= `NH;
					PCWrite <= 1'b1;
					IFWrite <= 1'b1;
					Bubble <= 1'b0;
				end
				else if(~Jump && Branch && ~comp1 && ~comp2 && ~comp3) begin
					NextState <= `B;
					PCWrite <= 1'b0;
					IFWrite <= 1'b0;
					Bubble <= 1'b0;
				end
			end
			`C1: begin
				NextState <= `C2;
				PCWrite <= 1'b0;
				IFWrite <= 1'b0;
				Bubble <= 1'b1;
			end
			`C2: begin
				NextState <= `NH;
				PCWrite <= 1'b0;
				IFWrite <= 1'b0;
				Bubble <= 1'b1;
			end
			`B: begin
				NextState <= `B1;
				PCWrite <= 1'b0;
				IFWrite <= 1'b0;
				Bubble <= 1'b1;
			end
			`B1: begin
				if(ALUZero4) begin
					NextState <= `B2;
					PCWrite <= 1'b1;
					IFWrite <= 1'b0;
					Bubble <= 1'b1;
				end
				else if(~ALUZero4) begin
					NextState <= `NH;
					PCWrite <= 1'b1;
					IFWrite <= 1'b1;
					Bubble <= 1'b1;
				end
			end
			`B2: begin
				NextState <= `NH;
				PCWrite <= 1'b1;
				IFWrite <= 1'b1;
				Bubble <= 1'b1;
			end
			default: begin
				NextState <= `NH;
				PCWrite <= 1'b1;
				IFWrite <= 1'b1;
				Bubble <= 1'b0;
			end
		endcase
	end
	
endmodule
