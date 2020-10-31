// -----------------------------------------------
// Sumador completo de un bit
// -----------------------------------------------
// Entradas: A, B, Cin
// Salida Cout y S


module sumador_completo (a, b, ci, s, co);      // see complete adder diagram on docs
  parameter
    PwrC = 0;
    wire s1,s2,s3,s4,s5,s6;

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
module SUM_RIZADO(a, b, ci, s, co);
  parameter
    PwrC = 0;


endmodule
