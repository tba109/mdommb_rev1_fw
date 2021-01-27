//
// Deserializes ICM clock counter data sent via ICM_GPIO_0
//
// Protocol described in the ICM DSN
//
// Aaron Fienberg
// January 22, 2021

module icm_ltc_des #(parameter SHIFT_CNT = 20,
                     parameter IDLE_CNT = 2000,
                     parameter STOP_ERR_CNT = 100) (
  input clk,
  input rst,

  input en, // enable
  input ser_in,

  output reg[47:0] ltc_out = 0,
  output reg valid_out = 0
);

wire ser_in_s;
sync SYNC_ICM_FPGA_SYNC_0(.clk(clk),.rst_n(!rst),
                          .a(ser_in),.y(ser_in_s));

// ser_in must idle high for IDLE_CNT clock cycles before
// the deserializer will accept messages.
// This prevents glitches if this module is enabled in the middle
// of a clock transfer

// error if ser_in does not go high after
// waiting STOP_ERR_CNT clock cycles in the stop bit

localparam S_IDLE = 0,
           S_RDY = 1,
           S_START = 2,
           S_SHIFT = 3,
           S_STOP = 4;
reg[2:0] fsm = S_IDLE;
reg[31:0] cnt = 0;
reg[31:0] bit_cnt = 0;
reg[50:0] shift_reg = 0;

always @(posedge clk) begin
  if (rst || !en) begin
    ltc_out <= 0;
    valid_out <= 0;
    shift_reg <= 0;

    cnt <= 0;
    bit_cnt <= 0;
    fsm <= S_IDLE;
  end else begin
    valid_out <= valid_out;
    ltc_out <= ltc_out;

    case (fsm)
      S_IDLE: begin
        valid_out <= 0;
        ltc_out <= 0;

        cnt <= 0;
        fsm <= S_IDLE;
        if (ser_in_s == 1'b1) begin
          cnt <= cnt + 1;
          if (cnt >= IDLE_CNT - 1) begin
            cnt <= 0;
            fsm <= S_RDY;
          end
        end
      end

      S_RDY: begin
        cnt <= 0;
        fsm <= S_RDY;
        if (ser_in_s == 1'b0) begin
          cnt <= 1;
          fsm <= S_START;
        end
      end

      S_START: begin
        cnt <= cnt + 1;
        fsm <= S_START;
        if (cnt >= SHIFT_CNT >> 1) begin
          shift_reg <= 0;
          cnt <= 0;
          bit_cnt <= 0;
          fsm <= S_SHIFT;
        end
      end

      S_SHIFT: begin
        cnt <= cnt + 1;
        fsm <= S_SHIFT;
        if (cnt == SHIFT_CNT - 1) begin
          shift_reg <= {shift_reg[49:0], ser_in_s};

          cnt <= 0;
          bit_cnt <= bit_cnt + 1;
          if (bit_cnt >= 50) begin
            fsm <= S_STOP;
          end
        end
      end

      S_STOP: begin
        cnt <= cnt + 1;

        fsm <= S_STOP;
        if ((cnt >= SHIFT_CNT >> 1) && ser_in_s == 1'b1) begin
          cnt <= 0;

          fsm <= S_RDY;
          // check start and stop bits
          if (shift_reg[50:49] == 2'b10 &&
              shift_reg[0] == 1'b0) begin
            ltc_out <= shift_reg[48:1];
            valid_out <= 1;
          end else begin
            // error
            valid_out <= 0;
          end
        end else if (cnt >= STOP_ERR_CNT - 1) begin
          // error, return to idle condition
          cnt <= 0;
          valid_out <= 0;
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