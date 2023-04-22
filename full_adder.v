module full_adder(
  input  wire i_A ,    // Input A
  input  wire i_B ,    // Input B
  input  wire i_carry, // Input carry
  output wire o_S,     // Output sum
  output wire o_carry  // Output carry
);

  assign o_S = (i_A ^ i_B) ^ i_carry;  // Compute the sum output
  assign o_carry = ((i_A ^ i_B) & i_carry) | (i_A & i_B);  // Compute the carry output

endmodule
