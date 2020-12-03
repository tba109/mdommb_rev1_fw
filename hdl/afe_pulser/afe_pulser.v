// Aaron Fienberg
// December 2020
//
// AFE pulser output control for the mDOM
//

module afe_pulser (
  input clk,
  input rst,
  input fastclk,

  // controls
  input io_rst,
  input trig,
  input y0, // idle level
  input[15:0] width,

  output out
);

reg[5:0] out_bits = 6'b0;
// invert out_bits if y0 idle level is high
wire[5:0] oserdes_word = y0 == 0 ? out_bits : ~out_bits;
AFE_PULSER_OUTPUT AFE_OUT (
  .data_out_from_device(oserdes_word),
  .data_out_to_pins(out),
  .clk_in(fastclk),
  .clk_div_in(clk),
  .io_reset(io_rst)
);

wire trig_pe;
posedge_detector PEDGE_TRIG(.clk(clk), .rst_n(!rst), .a(trig), .y(trig_pe));

// FSM logic
localparam
  S_IDLE = 0,
  S_FIRE = 1;
reg[2:0] fsm = S_IDLE;

reg[15:0] cnt = 0;
always @(posedge clk) begin
  if (rst) begin
    out_bits <= 6'b0;
    cnt <= 0;
    fsm <= S_IDLE;
  end

  else begin
    out_bits <= 0;

    case (fsm)
      S_IDLE: begin
        cnt <= 0;

        if (trig_pe) begin
          fsm <= S_FIRE;
          cnt <= width;
        end
      end

      S_FIRE: begin
        if (cnt > 16'd6) begin
          out_bits <= 6'h3f;

          cnt <= cnt - 6;
          fsm <= S_FIRE;
        end

        else begin
          case (cnt)
            6: out_bits <= 6'h3f;
            5: out_bits <= 6'h1f;
            4: out_bits <= 6'h0f;
            3: out_bits <= 6'h07;
            2: out_bits <= 6'h03;
            1: out_bits <= 6'h01;
            0: out_bits <= 6'h0;
            default: out_bits <= 6'h0;
          endcase

          cnt <= 0;
          fsm <= S_IDLE;
        end
      end

      default: begin
        fsm <= S_IDLE;
      end

    endcase
  end
end

endmodule