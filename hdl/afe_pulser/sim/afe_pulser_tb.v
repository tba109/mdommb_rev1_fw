// Aaron Fienberg
//
// Test bench for the mDOM afe_pulser module
//

`timescale 1ns/1ns

module afe_pulser_tb();

parameter CLK_PERIOD = 8;
parameter FASTCLK_PERIOD = 1;

reg lclk;
reg divclk;
reg fastclk;
initial begin
  // clock initialization
  lclk = 1'b0;
  fastclk = 1'b0;
  #3
  divclk = 1'b0;
end

// clock drivers
always @(lclk)
  #(CLK_PERIOD / 2.0) lclk <= !lclk;

always @(divclk)
  #(CLK_PERIOD / 2.0) divclk <= !divclk;

always @(fastclk)
  #(FASTCLK_PERIOD / 2.0) fastclk <= !fastclk;

reg trig = 0;
reg[15:0] width = 0;
reg io_rst = 1;
reg lclk_rst = 0;
reg divclk_rst = 0;
wire pulser_out;
reg y0 = 0;
afe_pulser pulser_0 (
  .lclk(lclk),
  .lclk_rst(lclk_rst),
  .divclk(divclk),
  .divclk_rst(divclk_rst),
  .fastclk(fastclk),
  .io_rst(io_rst),
  .trig(trig),
  .y0(y0),
  .width(width),
  .out(pulser_out)
);

integer cnt = 0;
always @(posedge lclk) begin
  cnt <= cnt + 1;
  trig <= 0;

  if (cnt == 10) io_rst <= 0;
  if (cnt == 20) begin
    width <= 12;
    trig <= 1;
  end
  if (cnt == 40) begin
    width <= 7;
    trig <= 1;
  end
  if (cnt == 50) begin
    width <= 6;
    trig <= 1;
  end
  if (cnt == 50) begin
    width <= 6;
    trig <= 1;
  end
  if (cnt == 60) begin
      width <= 5;
      trig <= 1;
  end
  if (cnt == 70) begin
      width <= 4;
      trig <= 1;
  end
  if (cnt == 90) begin
      width <= 3;
      trig <= 1;
  end
  if (cnt == 100) begin
      width <= 2;
      trig <= 1;
  end
  if (cnt == 110) begin
      width <= 1;
      trig <= 1;
  end

  if (cnt == 115) begin
      width <= 0;
      trig <= 1;
  end

  if (cnt == 120) y0 <= 1;
  if (cnt == 130) begin
    width <= 3;
    trig <= 1;
  end
end

endmodule