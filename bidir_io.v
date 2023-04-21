module bidir_io #(parameter WIDTH=1) (
  input  wire           t , // Control signal for driving the inout port
  inout  wire [WIDTH-1] i , // Input port
  output wire [WIDTH-1] o , // Output port
  inout  wire [WIDTH-1] io  // Inout port
);
  
  // Assign either input or high impedance to inout port based on control signal
  // If t is 1, assign input to inout port, else if t is 0, assign high impedance to inout port
  assign io = t ? i : {WIDTH{1'bz}};
  
  // Assign the value of the inout port to the output port
  assign o = io;
  
endmodule
