module n_bit_sipo_shift_reg #(
  parameter WIDTH = 8 // number of bits in the shift register
)(
  input  wire             clk        , // Clock signal
  input  wire             rst        , // Reset signal
  input  wire             i_serial   , // Serial signal
  output reg  [WIDTH-1:0] o_parallel   // Parallel signal
);

reg [WIDTH-1:0] shift_reg;

always @(posedge clk) begin
  if (rst) begin
    shift_reg <= {WIDTH{1'b0}}; // reset the shift register to 0
  end
  else begin
    shift_reg <= {shift_reg[WIDTH-2:0], i_serial}; // shift in the new input
  end
end

assign o_parallel = shift_reg;

endmodule
