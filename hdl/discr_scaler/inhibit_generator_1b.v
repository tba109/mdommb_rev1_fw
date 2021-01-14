// Aaron Fienberg
// January 2020
//
// 1-bit version of the scaler inhibit generator
//

module inhibit_generator_1b #(parameter P_N_WIDTH=32)
(
  input          clk,
  input          rst,

  // Controls
  input bits_in,
  input[P_N_WIDTH-1:0] inhibit_len,

  // Outputs
  output reg inhibit_bits = 0,
  output reg bits_out = 0
);

(* DONT_TOUCH = "true" *) reg[P_N_WIDTH-1:0] i_inhibit_len = 0;
always @(posedge clk) begin
  i_inhibit_len <= inhibit_len;
end

always @(posedge clk) begin
  bits_out <= bits_in;
end

wire trig_pe;
posedge_detector PEDGE_TRIG(.clk(clk), .rst_n(!rst),
                            .a(bits_in), .y(trig_pe));

localparam S_IDLE = 0,
           S_INHIBITED = 1;
reg[1:0] fsm = S_IDLE;
reg[P_N_WIDTH-1:0] cnt = 0;
reg final_cycle_flag = 0;

wire inhibit_trig = trig_pe && !final_cycle_flag;

always @(posedge clk) begin
  if (rst || i_inhibit_len == 0) begin
    cnt <= 0;
    inhibit_bits <= 0;
    final_cycle_flag <= 0;
    fsm <= S_IDLE;
  end

  else begin
    case (fsm)
      S_IDLE: begin
        final_cycle_flag <= 0;

        if (inhibit_trig) begin
          final_cycle_flag <= 1;
          inhibit_bits <= 0;
        end else begin
          inhibit_bits <= final_cycle_flag;
        end

        if (inhibit_trig && i_inhibit_len > 1) begin
          cnt <= 1;
          fsm <= S_INHIBITED;
        end else begin
          cnt <= 0;
          fsm <= S_IDLE;
        end
      end

      S_INHIBITED: begin
        cnt <= cnt + 1;
        inhibit_bits <= 1;
        if (cnt >= i_inhibit_len - 1) begin
          fsm <= S_IDLE;
        end
      end

      default: begin
        inhibit_bits <= 0;
        final_cycle_flag <= 0;
        fsm <= S_IDLE;
      end
    endcase
  end
end


endmodule