// Aaron Fienberg
//
// Test bench for the mDOM 1-bit / ADC scaler
//

`timescale 1ns/1ns

module scaler_tb_1bit();

parameter CLK_PERIOD = 8;

reg lclk;
initial begin
  // clock initialization
  lclk = 1'b0;
end

// clock drivers
always @(lclk)
  #(CLK_PERIOD / 2.0) lclk <= !lclk;

reg rst;
reg[31:0] period;
reg[31:0] inhibit_len;
reg tot = 0;
wire valid;
wire[3:0] n_pedge_out;
wire update_out;
discr_scaler #(.P_N_WIDTH(4), .P_INPUT_WIDTH(1)) SCALER (
  .clk(lclk),
  .rst(rst),
  .discr_in(tot),
  .inhibit_len(inhibit_len),
  .period(period),
  .valid(valid),
  .n_pedge_out(n_pedge_out),
  .update_out(update_out)
);

initial begin
  period = 10;
  inhibit_len = 2;
  rst = 1;
  tot = 0;
end

integer cnt = 0;
always @(posedge lclk) begin
  cnt <= cnt + 1;
  tot <= 0;

  if (cnt == 10) rst <= 0;

  if (cnt == 15) tot <= 0;
  if (cnt == 16) tot <= 1;
  if (cnt == 17) tot <= 0;
  if (cnt == 18) tot <= 1;
  if (cnt == 19) tot <= 0;
  if (cnt == 20) tot <= 0;
  if (cnt == 21) tot <= 0;
  if (cnt == 22) tot <= 1;
  if (cnt == 23) tot <= 0;
  if (cnt == 24) tot <= 0;
  if (cnt == 25) tot <= 1;
  if (cnt == 26) tot <= 0;
  if (cnt == 27) tot <= 0;

end

endmodule