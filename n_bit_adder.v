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

module n_bit_adder #(
  parameter WIDTH = 4
)(
  input  wire [WIDTH-1:0] i_A ,      // Input A
  input  wire [WIDTH-1:0] i_B ,      // Input B
  output wire [WIDTH-1:0] o_S        // Output sum
);

  wire [WIDTH:0]   i_carry;         // Declare an array of wires for carry input to each full adder
  wire [WIDTH-1:0] o_carry;         // Declare an array of wires for carry output from each full adder
  
  // Initialize the first element of the i_carry array to 0
  assign i_carry[0] = 1'b0;
  
  // Generate a chain of full adders using a for loop
  genvar i;
  generate 
    for (i = 0; i < WIDTH; i = i+1) begin: full_adder_chain
      // Instantiate a full adder module
      full_adder full_adder_i (
        .i_A(i_A[i]),
        .i_B(i_B[i]),
        .i_carry(i_carry[i]),
        .o_S(o_S[i]),
        .o_carry(o_carry[i])
      );
      
      // Connect the carry output of the current full adder to the carry input of the next full adder
      assign i_carry[i+1] = o_carry[i];
    end
  endgenerate
  
  // Assign the carry output of the last full adder to the output carry
  assign o_carry = o_carry[WIDTH-1];
  
endmodule
