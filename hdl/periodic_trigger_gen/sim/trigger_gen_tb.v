// Aaron Fienberg
//
// Test bench for the periodic trigger gn
//

`timescale 1ns/1ns

module trigger_gen_tb();

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
wire trig;

periodic_trigger_gen TRIG_GEN(.clk(lclk), .rst(rst), .period(period), .trig(trig));

initial begin
  period = 0;
  rst = 1;
end

integer cnt = 0;
always @(posedge lclk) begin
  cnt <= cnt + 1;
  if (cnt == 10) rst <= 0;
  if (cnt == 15) period <= 1;
  if (cnt == 20) period <= 2;
  if (cnt == 30) period <= 5;
  if (cnt == 50) period <= 10;
end

endmodule