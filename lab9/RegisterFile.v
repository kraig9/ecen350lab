`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk); //module starts...

//outputs
output [31:0] BusA; //32 bits outputs
output [31:0] BusB; //32 bits outputs

//inputs
input [31:0] BusW; //32 bits inputs
input [4:0] RA; //five bits inputs
input [4:0] RB; //five bits inputs
input [4:0] RW; //five bits inputs
input RegWr; //register write
input Clk; //clock
integer i;
reg [31:0] registers [31:0]; //There 32 of 32-bit registers

initial begin
for (i = 0; i <32; i = i + 1)
	registers[i] = 0;
end

assign BusA = (RA==0) ? 0:registers[RA]; //read from RA to BusA with a delay of 2 sec
assign BusB = (RB==0) ? 0:registers[RB]; //read from RB to BusB with a delay of 2 sec

always @ (negedge Clk) begin //Clk always begins from negative edge
	if(RegWr & RW>0) 
		registers[RW] <= BusW; //write the value of BusW into RW
end

endmodule //end...