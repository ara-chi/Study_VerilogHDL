module n_stage_synchronizer
#(
  parameter NUM_STAGE  = 3,
  parameter DATA_WIDTH = 8
)
(
  input wire i_clk,                   // clock signal
  input wire [DATA_WIDTH-1:0] i_data, // input data synced with another clock
  output reg [DATA_WIDTH-1:0] o_data  // output data synced with i_clk
);

  genvar i;
  generate
    for (i=0; i<NUM_STAGE; i=i+1) begin : stage_block
      reg [DATA_WIDTH-1:0] stage_reg;
      
      always @(posedge i_clk) begin
        if (i==0) begin
          stage_reg <= i_data;
        end
        else begin
          stage_reg <= stage_block[i-1].stage_reg;
        end
      end
      
    end
  endgenerate

  //from the last stage
  assign o_data = stage_block[NUM_STAGE-1].stage_reg;

endmodule
