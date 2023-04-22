module master_fsm(
  input  wire       clk          ,  // System clock
  input  wire       rst          ,  // Reset signal
  input  wire       start        ,  // Start signal
  output reg  [1:0] state = IDLE ,  // FSM state
  output reg        busy  = 1'b0 ,  // Busy signal
  output reg        done  = 1'b1    // Done signal
);

  // FSM states
  localparam IDLE            = 2'b00; // FSM state: idle
  localparam START_SLAVE_FSM = 2'b01; // FSM state: start slave FSM
  localparam WAIT_SLAVE_FSM  = 2'b10; // FSM state: wait for slave FSM to complete
  localparam ERROR           = 2'b11; // FSM state: error

  localparam TIMEOUT_PERIOD = 50000000; // Time-out period for waiting on slave FSM

  // Internal signals
  reg  [1:0]  state = IDLE;            // FSM state
  reg         slave_fsm_start = 1'b0;  // Start signal for slave FSM
  wire [1:0]  slave_fsm_state;         // Current state of slave FSM
  wire        slave_fsm_busy;          // Busy signal from slave FSM
  wire        slave_fsm_done;          // Done signal from slave FSM
  reg  [31:0] timeout_counter = 32'd0; // Counter for time-out period
  wire        timeout;                 // Time-out signal

  // Calculate time-out signal
  timeout <= (timeout_counter >= TIMEOUT_PERIOD) ? 1'b1 : 1'b0;

  // FSM logic
  always @(posedge clk) begin
    if (rst) begin
      // Reset FSM and internal signals
      state <= IDLE;
      slave_fsm_start <= 1'b0;
      busy <= 1'b0;
      done <= 1'b1;
      timeout_counter <= 32'd0;
      timeout <= 1'b0;
    end
    else begin
      case (state)
        IDLE: begin
          // Start slave FSM when start signal is received
          if (start) begin
            state <= START_SLAVE_FSM;
            slave_fsm_start <= 1'b1;
            busy <= 1'b1;
            done <= 1'b0;
          end
        end
        START_SLAVE_FSM: begin
          // Transition to wait state and clear start signal to slave FSM
          state <= WAIT_SLAVE_FSM;
          slave_fsm_start <= 1'b0;
        end
        WAIT_SLAVE_FSM: begin
          // Increment timeout counter and check for time-out or completion signals
          timeout_counter <= timeout_counter + 1'd1;
          if ((timeout) | (~slave_fsm_busy & slave_fsm_done)) begin
            // Transition back to idle state when time-out or completion signals are detected
            state <= IDLE;
            busy <= 1'b0;
            done <= 1'b1;
          end
        end
        default: begin
          // Transition to error state for undefined FSM states
          state <= ERROR;
        end
      endcase
    end
  end

  // Slave FSM instantiation
  slave_fsm slave_fsm_1(
    .clk   (clk),
    .rst   (rst),
    .start (slave_fsm_start),
    .state (slave_fsm_state),
    .busy  (slave_fsm_busy),
    .done  (slave_fsm_done)
  );

endmodule
