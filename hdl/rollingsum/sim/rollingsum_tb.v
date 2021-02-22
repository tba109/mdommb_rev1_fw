// test rollingsum_lutram

`timescale 1ns/1ns

module rollingsum_tb();

parameter CLK_PERIOD = 8;
reg clk;
initial begin
 // clock initialization
 clk = 1'b0;
end

always @(clk)
 #(CLK_PERIOD / 2.0) clk <= !clk;

// input/output data
reg rst = 1;
reg[11:0] d_in = 0;

reg trig = 0;
reg pause = 0;
reg pause_ovr = 0;
reg[7:0] sum_len = 0;

reg[15:0] pause_len = 4;

wire[18:0] sum_out;
wire sum_valid;

rollingsum_lutram sum (
  .clk(clk),
  .rst_n(!rst),
  .d_in(d_in),
  .trig(trig),
  .pause(pause),
  .pause_ovr(pause_ovr),
  .sum_len(sum_len),
  .pause_len(pause_len),
  .sum_out(sum_out),
  .valid(sum_valid)
);

integer cnt = 0;
always @(posedge clk) begin
  cnt <= cnt + 1;
  d_in <= d_in + 1;

  trig <= 0;

  if (cnt == 0) begin
    d_in <= 1;
  end

  if (cnt == 9) begin
    rst <= 0;
    sum_len <= 1;
  end

  if (cnt == 19) begin
    trig <= 1;
  end

  if (cnt == 50) begin
    sum_len <= 31;
  end

  if (cnt == 200) begin
    sum_len <= 128;
  end
end

endmodule