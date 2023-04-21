module bidir_io #(parameter WIDTH=1) (
  input  wire           t , // Control signal for driving the inout port
  inout  wire [WIDTH-1] i , // Bidirectional port
  output wire [WIDTH-1] o , // Output port
  inout  wire [WIDTH-1] io  // Bidirectional port
);
  
  // Assign either input or high impedance to inout port based on control signal
  assign io = t ? i : {WIDTH{1'bz}};
  
  // Assign the value of the inout port to the output port
  assign o = io;
  
endmodule
