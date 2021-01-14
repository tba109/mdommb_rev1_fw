// Aaron Fienberg
// December 2020
//
// Counts positive edges in the discriminator bitstream
//
// Also used for ADC threshold scalers,
// which treat the over-threshold signal as a 1-bit discriminator
//
// based on bitstream_counter.v, by Tyler Anderson, from the mDOT project
//

module discr_scaler #(parameter P_N_WIDTH=32, P_INPUT_WIDTH=8)
(
  input          clk,
  input          rst,

  // Controls
  input [P_INPUT_WIDTH-1:0]  discr_in,
  input [P_N_WIDTH-1:0]      period,
  input [P_N_WIDTH-1:0]      inhibit_len,

  // Outputs
  output reg           valid=0,
  output reg[P_N_WIDTH-1:0] n_pedge_out=0,
  output               update_out
);

wire[P_INPUT_WIDTH-1:0] discr_in_1;
wire[P_INPUT_WIDTH-1:0] inhibit_bits;
generate
  if (P_INPUT_WIDTH == 8) begin
    // 8 bit inhibit generator
    inhibit_generator_8b #(.P_N_WIDTH(P_N_WIDTH)) INH_GEN (
      .clk(clk),
      .rst(rst),
      .bits_in(discr_in),
      .inhibit_len(inhibit_len),
      .inhibit_bits(inhibit_bits),
      .bits_out(discr_in_1)
    );
  end else if (P_INPUT_WIDTH == 1) begin
    // 1 bit inhibit generator
    inhibit_generator_1b #(.P_N_WIDTH(P_N_WIDTH)) INH_GEN (
      .clk(clk),
      .rst(rst),
      .bits_in(discr_in),
      .inhibit_len(inhibit_len),
      .inhibit_bits(inhibit_bits),
      .bits_out(discr_in_1)
    );
  end else begin
    invalid_module_conf ONLY_P_INPUT_WIDTH_8_OR_1_IS_SUPPORTED();
  end
endgenerate

// Internals
wire[P_N_WIDTH-1:0]        running_sum_0;
reg[P_N_WIDTH-1:0]         running_sum_1 = 0;

// Window update flag
reg [P_N_WIDTH-1:0]        i_cnt = 0;
wire           update_0;

// period must be >= 3 for logic to work here
(* DONT_TOUCH = "true" *) reg[P_N_WIDTH-1:0] i_period = 0;
always @(posedge clk) begin
  i_period <= period < 32'd3 ? 32'd3 : period;
end

wire i_rst = rst || i_period == 0;

assign update_0 = i_cnt >= i_period - 1;
reg update_1 = 0;
reg update_2 = 0;
assign update_out = update_2;

always @(posedge clk) begin
  if (i_rst) begin
    i_cnt <= 0;
  end

  else if (update_0) begin
    i_cnt <= 0;
  end

  else begin
    i_cnt <= i_cnt + 1;
  end
end

always @(posedge clk) begin
  if (i_rst) begin
    update_1 <= 0;
    update_2 <= 0;
  end

  else begin
    update_1 <= update_0;
    update_2 <= update_1;
  end
end

// register to keep track
// of last bit from previous cycle
reg prev_last_bit = 0;
always @(posedge clk) begin
  prev_last_bit <= discr_in_1[P_INPUT_WIDTH-1];
end

// bits on which to search for positive edges
wire[P_INPUT_WIDTH:0] stream_bits = {discr_in_1, prev_last_bit};

reg[P_INPUT_WIDTH-1:0] pedge_sum = 0;
integer i;
always @(*) begin
  pedge_sum = 0;
  for (i = 0; i < P_INPUT_WIDTH; i = i + 1) begin
    // count transitions from 0 to 1 at non-inhibited bit positions
    if (stream_bits[i+1] && !stream_bits[i] && !inhibit_bits[i]) begin
      pedge_sum = pedge_sum + 1;
    end
  end
end

reg[P_INPUT_WIDTH-1:0] last_pedge_sum = 0;
always @(posedge clk) begin
  last_pedge_sum <= pedge_sum;
end
// potentially overflowing value
wire[P_N_WIDTH-1:0] next_scaler_val = running_sum_1 + last_pedge_sum;
assign running_sum_0 = next_scaler_val;

// overflow detector
// MSB switching from 1 to 0 indictates an overflow
wire overflow_detected = running_sum_1[P_N_WIDTH-1] && !running_sum_0[P_N_WIDTH-1];
reg overflow = 0;

// Update the internal counter
always @(posedge clk) begin
  if (i_rst) begin
    running_sum_1 <= 0;
    overflow <= 0;
  end

  else begin
    running_sum_1 <= running_sum_0;

    if (update_1) begin
      overflow <= 0;
      running_sum_1 <= 0;
    end else begin
      overflow <= overflow || overflow_detected;
    end
  end
end

// update the output
always @(posedge clk) begin
  if (i_rst) begin
    valid <= 0;
    n_pedge_out <= 0;
  end

  else if (update_1) begin
    valid <= 1;
    // check for overflow on the last clock cycle of the scaler period
    n_pedge_out <= overflow || overflow_detected ? {P_N_WIDTH{1'b1}} : running_sum_0;
  end
end

endmodule
