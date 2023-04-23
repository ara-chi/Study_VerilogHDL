module n_bit_piso_shift_reg #(
  parameter WIDTH = 8 // number of bits in the shift register
)(
  input  wire             clk                , // Clock signal
  input  wire             rst                , // Reset signal
  input  wire [WIDTH-1:0] i_parallel         , // Parallel signal
  output reg              o_serial  = 1'b0     // Serial signal
);

  reg [WIDTH-1:0] shift_reg = {WIDTH{1'b0}};

always @(posedge clk) begin
  if (rst) begin
    shift_reg <= {WIDTH{1'b0}}; //reset shift register to 0
    o_serial <= 1'b0; //reset serial output to 0
  end
  else begin
    shift_reg <= {i_parallel, shift_reg[WIDTH-1:1]}; //shift in parallel input and shift out serial output
    o_serial <= shift_reg[0]; //update serial output
  end
end

endmodule
