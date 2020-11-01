// -----------------------------------------------
// Sumador completo de un bit
// -----------------------------------------------
// Entradas: A, B, Cin
// Salida Cout y S
`timescale 1ns/1ps

module sumador_completo (a, b, ci, s, co);      // see complete adder diagram on docs
  parameter
    PwrC = 0;
  input wire a,b,ci;
  output reg s,co;
  wire s1,s2,s3,s4,s5,s6;
/*
  xor2_p xor1(
    //INPUTS
    .c     (a),
    .b     (b),
    // OUTPUTS
    .a     ( s1)
  );

    xor2_p xor2(
    //INPUTS
    .c     (s1),
    .b     (ci),
    // OUTPUTS
    .a     (s2)
  );
*/
// new designe, with only one Xor 3 inputs
  xor3_p xor1(
    //INPUTS
    .c     (a),
    .b     (b),
    .d     (ci),
    // OUTPUTS
    .a     ( s2)
  );

// carry logic

  and2_p and1(
    //INPUTS
    .c     (ci),
    .b     (a),
    // OUTPUTS
    .a     ( s3)
  );

    and2_p and2(
    //INPUTS
    .c     (ci),
    .b     (b),
    // OUTPUTS
    .a     ( s4)
  );

    and2_p and3(
    //INPUTS
    .c     (a),
    .b     (b),
    // OUTPUTS
    .a     ( s5)
  );


   or3_p or1(
    //INPUTS
    .b     (s3),
    .c     (s4),
    .d     (s5),
    // OUTPUTS
    .a     ( s6)
  );


  always@(*) begin
    s = s2;
    co = s6;
  end

endmodule


// -----------------------------------------------
// Sumador rizado de 8 bits
// -----------------------------------------------
// this module can be implemented more quickly with a generate block.

module SUM_RIZADO(a, b, ci, s, co);
  parameter
    PwrC = 0;
  input wire [7:0] a,b;
  input wire ci;
  output reg [7:0] s;
  output reg co;
  wire [7:0] carry, sn; //c0,c1,c2,c3,c4,c5,c6,c7,s0,s1,s2,s3,s4,s5,s6,s7;

  sumador_completo sum0(
    //inputs
    .a      (a[0]),
    .b      (b[0]),
    .ci     (ci),
    //outputs
    .s      (sn[0]),
    .co     (carry[0])
  );

  sumador_completo sum1(
    //inputs
    .a      (a[1]),
    .b      (b[1]),
    .ci     (carry[0]),
    //outputs
    .s      (sn[1]),
    .co     (carry[1])
  );

  sumador_completo sum2(
    //inputs
    .a      (a[2]),
    .b      (b[2]),
    .ci     (carry[1]),
    //outputs
    .s      (   sn[2]),
    .co     (carry[2])
  );

  sumador_completo sum3(
    //inputs
    .a      (a[3]),
    .b      (b[3]),
    .ci     (carry[2]),
    //outputs
    .s      (   sn[3]),
    .co     (carry[3])
  );

  sumador_completo sum4(
    //inputs
    .a      (a[4]),
    .b      (b[4]),
    .ci     (carry[3]),
    //outputs
    .s      (   sn[4]),
    .co     (carry[4])
  );

  sumador_completo sum5(
    //inputs
    .a      (a[5]),
    .b      (b[5]),
    .ci     (carry[4]),
    //outputs
    .s      (   sn[5]),
    .co     (carry[5])
  );

  sumador_completo sum6(
    //inputs
    .a      (a[6]),
    .b      (b[6]),
    .ci     (carry[5]),
    //outputs
    .s      (   sn[6]),
    .co     (carry[6])
  );

  sumador_completo sum7(
    //inputs
    .a      (a[7]),
    .b      (b[7]),
    .ci     (carry[6]),
    //outputs
    .s      (   sn[7]),
    .co     (carry[7])
  );

  always@(*) begin
    s = sn[7:0];
    co = carry[7];
  end

endmodule
