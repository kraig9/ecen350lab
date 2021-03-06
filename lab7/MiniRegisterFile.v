`timescale 1ns / 1ps

module MiniRegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [31:0] BusA;
    output [31:0] BusB;
    input [31:0] BusW;
    input [4:0] RA;
    input [4:0] RB;
    input [4:0] RW;
    input RegWr;
    input Clk;
    reg [31:0] registers [1:0];
     
    assign #2 BusA = (RA==0) ? 0:registers[RA];
    assign #2 BusB = (RB==0) ? 0:registers[RB];
     
    always @ (negedge Clk) begin
        if(RegWr & RW>0)
            registers[RW] <= #3 BusW;
    end
endmodule
