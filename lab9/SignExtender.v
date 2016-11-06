module SignExtender (BusImm, Imm16 , Ctrl); //module starts...

output [31:0] BusImm; //32 bit output
input [15:0] Imm16 ; //16 bit inputs
input Ctrl; //control signal

wire extBit; //bit to be added
assign extBit = ( Ctrl ? 1'b0 : Imm16[15] ); //assignments
assign BusImm = {{16{extBit}}, Imm16}; //extension

endmodule