// Aaron Fienberg
//
// Test bench for the mDOM discriminator scaler
//

`timescale 1ns/1ns

module scaler_tb();

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
reg[31:0] period ;
reg[7:0] discr_bits;
wire valid;
wire[3:0] n_pedge_out;
wire update_out;
discr_scaler #(.P_N_WIDTH(4)) SCALER (
  .clk(lclk),
  .rst(rst),
  .a(discr_bits),
  .period(period),
  .valid(valid),
  .n_pedge_out(n_pedge_out),
  .update_out(update_out)
);

initial begin
  period = 3;
  rst = 1;
  discr_bits = 0;
end

integer cnt = 0;
always @(posedge lclk) begin
  cnt <= cnt + 1;
  discr_bits <= 8'b0;

  if (cnt == 10) rst <= 0;

  if (cnt == 15) discr_bits <= 8'b01010101;
  if (cnt == 16) discr_bits <= 8'b10101010;
  if (cnt == 17) discr_bits <= 8'b00001000;
  if (cnt == 18) discr_bits <= 8'b00001010;
  if (cnt == 19) discr_bits <= 8'b01010010;

  if (cnt == 25) period <= 10;

  if (cnt == 30) discr_bits <= 8'b01010101;
  if (cnt == 31) discr_bits <= 8'b10101010;
  if (cnt == 32) discr_bits <= 8'b00001000;
  if (cnt == 33) discr_bits <= 8'b00001010;
  if (cnt == 34) discr_bits <= 8'b01010010;
  if (cnt == 35) discr_bits <= 8'b01011110;

  // test overflow
  if (cnt > 40 && cnt < 50) discr_bits <= 8'b01010101;
end

endmodule