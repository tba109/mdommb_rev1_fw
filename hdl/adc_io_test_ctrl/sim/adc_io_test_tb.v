//
// Test bench for adc_io test ctrl module
//

`timescale 1ns/1ns

module adc_io_test_tb();

parameter LCLK_PERIOD = 8;

reg lclk;
reg rst;
initial begin
  lclk = 1'b0;
  rst = 1'b1;

  #32
  rst = 1'b0;
end

always @(lclk)
  #(LCLK_PERIOD / 2.0) lclk <= !lclk;

wire spi_req;
wire[23:0] adc_spi_wr_data;
reg spi_ack = 0;
wire[7:0] adc_spi_rd_data = 8'h04;
wire adc_reset;
wire[3:0] state;
wire toggle;

adc_io_test_ctrl #(.TOGGLE_PERIOD(10)) adc_io_test (
  .clk(lclk),
  .rst(rst),
  .spi_req(spi_req),
  .adc_spi_wr_data(adc_spi_wr_data),
  .spi_ack(spi_ack),
  .adc_spi_rd_data(adc_spi_rd_data),
  .adc_reset(adc_reset),
  .state(state),
  .toggle(toggle)
);

// handle acks
reg req_prev = 0;
always @(posedge lclk) begin
  req_prev <= spi_req;
  if (spi_req && !req_prev) begin
    spi_ack <= 1;
  end else if (spi_ack && !spi_req) begin
    spi_ack <= 0;
  end else begin
    spi_ack <= spi_ack;
  end
end


endmodule