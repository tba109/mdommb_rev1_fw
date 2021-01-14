// Aaron Fienberg
// December 2020
//
// Generates "inhibit bits" for the discriminator scaler
//
// outputs inhibit bits and pipelined input bits
//
// works only with 8 bit input

module inhibit_generator_8b #(parameter P_N_WIDTH=32)
(
  input          clk,
  input          rst,

  // Controls
  input[7:0]  bits_in,
  input[P_N_WIDTH-1:0] inhibit_len,

  // Outputs
  output reg[7:0]  inhibit_bits = 0,
  output reg[7:0]  bits_out = 0
);

(* DONT_TOUCH = "true" *) reg[P_N_WIDTH-1:0] i_inhibit_len = 0;
always @(posedge clk) begin
  i_inhibit_len <= inhibit_len;
end

// latency is one clock cycle
always @(posedge clk) begin
  bits_out <= bits_in;
end

reg prev_last_bit = 0;
always @(posedge clk) begin
  prev_last_bit <= bits_in[7];
end

wire[7:0] trig;
assign trig[0] = bits_in[0] && !prev_last_bit;
generate
  genvar i;
  for (i = 1; i < 8; i = i + 1) begin
    assign trig[i] = bits_in[i] && !bits_in[i-1];
  end
endgenerate

localparam S_IDLE = 0,
           S_INHIBITED = 1;
reg[1:0] fsm = S_IDLE;
reg[7:0] last_cycle_inh_bits = 8'b0;
reg[P_N_WIDTH-1:0] cnt = 0;

// handles triggering on the first cycle after leaving
// the S_INHIBITED state
wire[7:0] inhibit_trig = trig & (~last_cycle_inh_bits);

always @(posedge clk) begin
  if (rst || i_inhibit_len == 0) begin
    cnt <= 0;
    inhibit_bits <= 8'b0;
    last_cycle_inh_bits <= 8'b0;
    fsm <= S_IDLE;
  end

  else begin
    case (fsm)
      S_IDLE: begin
        last_cycle_inh_bits <= 8'h0;

        if (inhibit_trig[0]) begin
          last_cycle_inh_bits <= 8'h1;
          inhibit_bits <= 8'hfe | last_cycle_inh_bits;
        end
        else if (inhibit_trig[1]) begin
          last_cycle_inh_bits <= 8'h3;
          inhibit_bits <= 8'hfc | last_cycle_inh_bits;
        end
        else if (inhibit_trig[2]) begin
          last_cycle_inh_bits <= 8'h7;
          inhibit_bits <= 8'hf8 | last_cycle_inh_bits;
        end
        else if (inhibit_trig[3]) begin
          last_cycle_inh_bits <= 8'hf;
          inhibit_bits <= 8'hf0 | last_cycle_inh_bits;
        end
        else if (inhibit_trig[4]) begin
          last_cycle_inh_bits <= 8'h1f;
          inhibit_bits <= 8'he0 | last_cycle_inh_bits;
        end
        else if (inhibit_trig[5]) begin
          last_cycle_inh_bits <= 8'h3f;
          inhibit_bits <= 8'hc0 | last_cycle_inh_bits;
        end
        else if (inhibit_trig[6]) begin
          last_cycle_inh_bits <= 8'h7f;
          inhibit_bits <= 8'h80 | last_cycle_inh_bits;
        end
        else if (inhibit_trig[7]) begin
          last_cycle_inh_bits <= 8'hff;
          inhibit_bits <= 8'h00 | last_cycle_inh_bits;
        end
        else begin
          inhibit_bits <= last_cycle_inh_bits;
        end

        if (|inhibit_trig && i_inhibit_len > 1) begin
          cnt <= 1;
          fsm <= S_INHIBITED;
        end else begin
          cnt <= 0;
          fsm <= S_IDLE;
        end
      end

      S_INHIBITED: begin
        cnt <= cnt + 1;
        inhibit_bits <= 8'hff;
        if (cnt >= i_inhibit_len - 1) begin
          fsm <= S_IDLE;
        end
      end

      default: begin
        inhibit_bits <= 8'b0;
        last_cycle_inh_bits <= 8'b0;
        fsm <= S_IDLE;
      end
    endcase

  end
end

endmodule
