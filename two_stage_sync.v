module two_stage_sync (
  input  wire clk , // Clock signal
  input  wire in  , // Input signal
  output reg  out   // Output signal synchronized to clk
);

  reg in_sync_1 = 1'b0;
  reg in_sync_2 = 1'b0;

  // Synchronize input signal to clock domain
  always @(posedge clk) begin
    in_sync_1 <= in;
    in_sync_2 <= in_sync_1;
    out       <= in_sync_2;
  end
  
endmodule
