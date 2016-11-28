`timescale 1ns / 1ps
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SLL 4'b0011
`define SRL 4'b0100
`define SUB 4'b0110
`define SLT 4'b0111 
`define ADDU 4'b1000
`define SUBU 4'b1001
`define XOR 4'b1010
`define SLTU 4'b1011
`define NOR 4'b1100
`define SRA 4'b1101
`define LUI 4'b1110

module ALU(BusW, Zero, BusA, BusB, ALUCtrl); //module starts

    parameter n = 32;
	
    output  [n-1:0] BusW; //32 bits outputs
    input   [n-1:0] BusA, BusB; //32 bits inputs
    input   [3:0] ALUCtrl; //4 bits control input
    output  Zero; //equals to 1 if BusW = 0
	wire [31:0] BusA_cmp,BusB_cmp; //32 bits variables

    assign BusA_cmp = {~(BusA[31]),BusA[30:0]}; // make it signed for SLT function
	assign BusB_cmp = {~(BusB[31]),BusB[30:0]}; // make it signed for SLT function
	
    reg     [n-1:0] BusW; //32 bits outputs
	reg		[n-1:0] temp;

    always @(ALUCtrl or BusA or BusB) begin
		case(ALUCtrl)  
		
			 `AND: begin            
				BusW <= #20 BusA & BusB;    //and
			 end         
		 
			 `OR: begin
				BusW <= #20 BusA | BusB;	//or
			 end
		 
			`ADD: begin
				BusW <= #20 $signed(BusA) + $signed(BusB);	//addition
			end

			`SLL: begin
				BusW <= #20 BusA << BusB;	//shift left logical
			end
			
			`SRL: begin
				BusW <= #20 BusA >> BusB;	//shift right logical
			end
			
			`SUB: begin
				BusW <= #20 $signed(BusA) - $signed(BusB);	//subtraction
			end
			
			`SLT: begin
				BusW <= #20 (BusA_cmp < BusB_cmp) ? 1 : 0;	//set on less than signed
			end
			
			`ADDU: begin
				BusW <= #20 BusA + BusB;	//add unsigned
			end
			
			`SUBU: begin
				BusW <= #20 BusA - BusB;	//subtract unsigned
			end
			
			`XOR: begin
				BusW <= #20 BusA ^ BusB;	//exclusive or
			end
			
			`SLTU: begin
				BusW <= #20(BusA < BusB) ? 1 : 0;	//set on less than unsigned
			end
			
			`NOR: begin
				BusW <= #20 ~(BusA | BusB);    //not or
			end
			
			`SRA: begin
				BusW <= #20 $signed(BusA) >>> BusB; //shift right arithmetic signed
			end
			
			`LUI: begin
				BusW <= #20{BusB[15:0], 16'b0};
				end
		endcase    
	end
	
assign #1 Zero = (BusW==32'b0) ? 1: 0;	//if BusW is 0, assign Zero to 1
endmodule 

