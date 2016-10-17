module Decode24(out,in);


input [1:0] in;

output [3:0] out;


wire n0,n1;


not not1(n0,in[0]);

not not2(n1,in[1]);

and and1(out[0],n0,n1);

and and2(out[1],in[0],n1);

and and3(out[2],n0,in[1]);

and and4(out[3],in[0],in[1]);


endmodule
