module HalfAdd (Cout, Sum, A, B);


input A,B;

output Cout,Sum;


wire n1,n2,n3;


nand nand1(n1,A,B);

nand nand2(n2,A,n1);

nand nand3(n3,B,n1);

nand nand4(Sum,n2,n3);

nand nand5(Cout,n1,n1);


endmodule
