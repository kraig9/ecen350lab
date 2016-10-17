module Mux21 (out, in, sel);


input [1:0] in;

input sel;

output out;


wire a0,a1,ns;


not not1(ns,sel);

and and1(a0,sel,in[1]);

and and2(a1,ns,in[0]);

or or1(out,a0,a1);


endmodule
