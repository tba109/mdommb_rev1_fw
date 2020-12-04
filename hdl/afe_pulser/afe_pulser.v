// Aaron Fienberg
// December 2020
//
// AFE pulser output control for the mDOM
//

module afe_pulser (
  input lclk,
  input lclk_rst,
  input divclk,
  input divclk_rst,
  input fastclk,

  // controls
  input io_rst,
  input trig,
  input y0, // idle level
  input[15:0] width,

  output out
);

reg[7:0] out_bits = 8'b0;
// invert out_bits if y0 idle level is high
wire[7:0] oserdes_word = y0 == 0 ? out_bits : ~out_bits;
AFE_PULSER_OUTPUT AFE_OUT (
  .data_out_from_device(oserdes_word),
  .data_out_to_pins(out),
  .clk_in(fastclk),
  .clk_div_in(divclk),
  .io_reset(io_rst)
);

// synchronize trigger signal coming from lclk domain
wire trig_os_out;
one_shot trig_os(.clk(lclk), .rst_n(!lclk_rst), .trig(trig), .n0(0), .n1(3),
                 .a0(1'b0), .a1(1'b1), .busy(), .y(trig_os_out));
wire trig_s;
sync trig_sync(.clk(divclk), .rst_n(!divclk_rst), .a(trig_os_out), .y(trig_s));

wire trig_pe;
posedge_detector PEDGE_TRIG(.clk(divclk), .rst_n(!divclk_rst), .a(trig_s), .y(trig_pe));

// FSM logic
localparam
  S_IDLE = 0,
  S_FIRE = 1;
reg[2:0] fsm = S_IDLE;

reg[15:0] cnt = 0;
always @(posedge divclk) begin
  if (divclk_rst) begin
    out_bits <= 8'b0;
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
        if (cnt > 16'd8) begin
          out_bits <= 8'hff;

          cnt <= cnt - 8;
          fsm <= S_FIRE;
        end

        else begin
          case (cnt)
            8: out_bits <= 8'hff;
            7: out_bits <= 8'h7f;
            6: out_bits <= 8'h3f;
            5: out_bits <= 8'h1f;
            4: out_bits <= 8'h0f;
            3: out_bits <= 8'h07;
            2: out_bits <= 8'h03;
            1: out_bits <= 8'h01;
            0: out_bits <= 8'h0;
            default: out_bits <= 8'h0;
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