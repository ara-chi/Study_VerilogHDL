module bidir_io_sync (
  input  wire clk, // Clock signal for synchronization
  input  wire t  , // Control signal for driving the inout port
  inout  wire i  , // Input port
  output wire o  , // Output port
  inout  wire io   // Inout port
);

  reg i_sync_1 = 1'b0;
  reg i_sync_2 = 1'b0;

  // Synchronize the input signal
  always @(posedge clk) begin
    i_sync_1 <= i;
    i_sync_2 <= i_sync_1;
  end
  
  // Assign either input or high impedance to inout port based on control signal
  // If t is 1, assign input to inout port, else if t is 0, assign high impedance to inout port
  assign io = t ? i_sync_2 : 1'bz;
  
  // Assign the value of the inout port to the output port
  assign o = io;
  
endmodule
