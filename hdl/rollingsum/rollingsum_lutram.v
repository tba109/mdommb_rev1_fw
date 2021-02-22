// rolling baseline sum for the mDOM
// based on rollingsum_buffered from the D-Egg project
//
// uses LUT RAM
//
// Aaron Fienberg
// Feb 2021

module rollingsum_lutram #(parameter SAMPLEBITS = 12,
                           parameter ADDRBITS = 7,
                           parameter INPUT_DELAY = 5)
 (
  // signal inputs
  input clk,
  input rst_n,
  input[SAMPLEBITS-1:0] d_in,
  input trig,
  input pause,     // external pause command;
                   // prevents the rolling sum from updating
  input pause_ovr, // overrides all pause signals;
                   // sum will continue updating even
                   // following a trigger

  // rolling sum configuration parameter inputs
  input[ADDRBITS:0] sum_len,
  input[15:0] pause_len, // how many clock ticks to pause for
                         // following a triger

  // outputs
  output reg[SAMPLEBITS + ADDRBITS - 1 : 0] sum_out = 0,
  output valid
 );

// do not allow sum_len to exceed 1 << ADDRBITS
localparam[31:0] MAX_SUM_LEN = 1 << ADDRBITS;
localparam[31:0] MIN_SUM_LEN = 3;
reg[ADDRBITS:0] i_sum_len = 0;
// keep track of prev_sum_len to detect changes;
// restart the sum when sum_len changes
reg[ADDRBITS:0] prev_sum_len = 0;

// register i_sum len and prev_sum_len
// i_sum_len must be in [MIN_SUM_LEN, MAX_SUM_LEN]
always @(posedge clk) begin
  i_sum_len <= sum_len > MAX_SUM_LEN ? MAX_SUM_LEN :
               sum_len < MIN_SUM_LEN ? MIN_SUM_LEN : sum_len;
  prev_sum_len <= i_sum_len;
end

// internal pause signal
wire pause_int;
pulse_extender #(.P_N_WIDTH(16)) trig_extender
  (
    .clk(clk),
    .reset_n(rst_n),
    .in(trig),
    .extend_len(pause_len),
    .out(pause_int)
  );

// the rolling sum can be paused by internal or external signals;
// the pause_override signal supercedes all others
wire paused = (pause || pause_int) && !pause_ovr;

// buffer write enable logic
// write whenever we are not paused and not in reset
wire buff_wren = rst_n && !paused;

// delay samples by a few clock cycles before
// going into the buffer to allow for some space between
// trigger edges and the last sample included in the sum
wire[SAMPLEBITS-1:0] d_in_delayed;
delay #(.DELAY(INPUT_DELAY),
        .BITS(SAMPLEBITS))
  samp_delay
  (
    .clk(clk),
    .reset_n(1'b1), // data stream should continue
                    // regardless of resets
    .d_in(d_in),
    .d_out(d_in_delayed)
  );

// the sample buffer
reg[ADDRBITS-1:0] buff_wr_addr = 0;
wire[ADDRBITS-1:0] buff_rd_addr;
// non-registered buffer outputs; offset of 1
// yields correct alignment while streaming
assign buff_rd_addr = buff_wr_addr - (i_sum_len - 1'd1);

wire[11:0] buff_d_out;
DIST_BUFFER_128_12 sample_buffer (
  .clk(clk),
  .a(buff_wr_addr),
  .d(d_in_delayed),
  .dpra(buff_rd_addr),
  .we(buff_wren),
  .dpo(buff_d_out),
  .qdpo_clk(clk)
);

// keep track of previous buff_d_out and previous state of buff_wren;
// this info is needed to handle the pause condition correctly
reg[11:0] prev_buff_dout = 0;
reg prev_buff_wren = 0;
always @(posedge clk) begin
  prev_buff_wren <= buff_wren;
  if (prev_buff_wren) begin
    prev_buff_dout <= buff_d_out;
  end
end

// sum update term; newest - oldest
localparam SUMBITS = SAMPLEBITS + ADDRBITS;
wire[11:0] oldest = prev_buff_wren ? buff_d_out : prev_buff_dout;
wire[SUMBITS-1:0] next_term = d_in_delayed - oldest;

// fsm states
localparam[1:0] S_FILLING   = 2'd0,
                S_ROLLING   = 2'd1,
                S_LENGTHONE = 2'd2;
reg[1:0] fsm = S_FILLING;

assign valid = fsm != S_FILLING;

wire restart = i_sum_len != prev_sum_len;

always @(posedge clk) begin
  if (!rst_n || i_sum_len == 0 || restart) begin
    fsm <= S_FILLING;
    sum_out <= 0;
    buff_wr_addr <= 0;
  end

  else begin
    case (fsm)
      S_FILLING: begin
        fsm <= S_FILLING;

        if (!paused) begin
          sum_out <= sum_out + d_in_delayed;
          buff_wr_addr <= buff_wr_addr + 1;

          if (buff_wr_addr == i_sum_len - 1) begin
            fsm <= S_ROLLING;
          end
        end

      end

      S_ROLLING: begin
        if (!paused) begin
          sum_out <= sum_out + next_term;
          buff_wr_addr <= buff_wr_addr + 1;
        end

        // we only leave this state
        // if the module is reset or
        // the sum length is changed
        // (see if (restart) block above)
        fsm <= S_ROLLING;
      end

      default: begin
        fsm <= S_FILLING;
        sum_out <= 0;
        buff_wr_addr <= 0;
      end

    endcase
  end
end


endmodule