// Aaron Fienberg
//
// Test bench for FPGA temp sync
//

`timescale 1ns/1ns

module temp_sync_tb();

parameter LCLK_PERIOD = 8;
parameter DDR3_CLK_PERIOD = 13;

reg lclk;
reg ddr3_clk;

initial begin
  // clock initialization
  lclk = 1'b0;
  #5
  ddr3_clk = 1'b0;
end

// clock drivers
always @(lclk)
  #(LCLK_PERIOD / 2.0) lclk <= !lclk;

always @(ddr3_clk)
  #(DDR3_CLK_PERIOD / 2.0) ddr3_clk <= !ddr3_clk;

reg[11:0] device_temp = 0;
wire[11:0] device_temp_out;

fpga_temp_sync TEMP_SYNC (
  .lclk(lclk),
  .lclk_rst(1'b0),
  .ddr3_clk(ddr3_clk),
  .ddr3_clk_rst(1'b0),
  .device_temp_in(device_temp),
  .device_temp_out(device_temp_out)
);

always @(posedge ddr3_clk) begin
  device_temp <= device_temp + 1;
end

endmodule