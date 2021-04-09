//
// Decodes ICM clock stamp sent via ICM_GPIO_0
//
// Provides status signals
//
// Adapted from the D-Egg for the mDOM (changed parameters)
//
// Aaron Fienberg
// January 2021
//

module icm_time_transfer #(parameter SHIFT_CNT=20,
                           parameter[47:0] EXPECTED_LTC_OFFSET=2) (
  input clk,
  input rst,

  // mainboard LTC
  input[47:0] ltc,

  input en, // enable
  input ser_in, // serial data in
  input sync_in, // sync pulse in

  output reg[47:0] ltc_wr_data = 0,
  output reg ltc_wr_req = 0,

  // status signals
  output reg rdy = 0, // ready
  output reg err = 0, // error detected
  output reg[47:0] expected_ltc = 0,
  output reg[47:0] received_ltc = 0
);

wire sync_s;
sync SYNC_ICM_FPGA_SYNC_0(.clk(clk),.rst_n(!rst),
                          .a(sync_in),.y(sync_s));
wire sync_pe;
posedge_detector PEDGE_ICM_FPGA_SYNC_0(.clk(clk), .rst_n(!rst),
                                       .a(sync_s),.y(sync_pe));

wire[47:0] ltc_des_out;
wire ltc_des_valid_out;
icm_ltc_des #(.SHIFT_CNT(SHIFT_CNT),
              .IDLE_CNT(4000),
              .STOP_ERR_CNT(200)) ICM_LTC_DES (
  .clk(clk),
  .rst(rst),
  .en(en),
  .ser_in(ser_in),

  .ltc_out(ltc_des_out),
  .valid_out(ltc_des_valid_out)
);

localparam S_IDLE = 0,
           S_NO_SYNC = 1,
           S_FIRST_SYNC = 2,
           S_RDY = 3;
reg[2:0] fsm = S_IDLE;

// EXPECTED_LTC_OFFSET is the offset between received LTC
// and internal LTC when sync pulse is received
wire[47:0] i_expected_ltc = ltc + EXPECTED_LTC_OFFSET;
wire ltc_match = i_expected_ltc == ltc_des_out;

// always record expected ltc / received_ltc when sync pulse arrives
always @(posedge clk) begin
  if (rst || !en) begin
    expected_ltc <= 48'b0;
    received_ltc <= 48'b0;
  end else begin
    expected_ltc <= expected_ltc;
    received_ltc <= received_ltc;
    if (sync_pe) begin
      expected_ltc <= i_expected_ltc;
      received_ltc <= ltc_des_out;
    end
  end
end

always @(posedge clk) begin
  if (rst || !en) begin
    ltc_wr_data = 48'b0;
    ltc_wr_req <= 0;
    rdy <= 0;
    err <= 0;

    fsm <= S_IDLE;
  end else begin
    ltc_wr_data <= 48'b0;
    ltc_wr_req <= 0;
    rdy <= 0;
    err <= 0;

    case (fsm)
      S_IDLE: begin
        fsm <= S_NO_SYNC;
      end

      S_NO_SYNC: begin
        fsm <= S_NO_SYNC;

        if (ltc_des_valid_out && sync_pe) begin
          ltc_wr_req <= 1;
          ltc_wr_data <= ltc_des_out;
          fsm <= S_FIRST_SYNC;
        end
      end

      S_FIRST_SYNC: begin
        err <= err;

        fsm <= S_FIRST_SYNC;
        if (ltc_des_valid_out && sync_pe) begin

          ltc_wr_req <= 1;
          ltc_wr_data <= ltc_des_out;

          if (ltc_match) begin
            rdy <= 1;
            err <= 0;
            fsm <= S_RDY;
          end else begin
            rdy <= 0;
            err <= 1;
            fsm <= S_FIRST_SYNC;
          end
        end else if (!ltc_des_valid_out) begin
          rdy <= 0;
          fsm <= S_NO_SYNC;
        end
      end

      S_RDY: begin
        rdy <= 1;
        err <= 0;

        fsm <= S_RDY;
        if (ltc_des_valid_out && sync_pe) begin
          ltc_wr_req <= 1;
          ltc_wr_data <= ltc_des_out;

          if (!ltc_match) begin
            rdy <= 0;
            err <= 1;
            fsm <= S_FIRST_SYNC;
          end
        end else if (!ltc_des_valid_out) begin
          rdy <= 0;
          fsm <= S_NO_SYNC;
        end
      end

      default: begin
        fsm <= S_IDLE;
      end
    endcase
  end
end

endmodule