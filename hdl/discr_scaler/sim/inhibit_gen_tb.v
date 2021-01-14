// Aaron Fienberg
//
// Test bench for the mDOM discriminator scaler inhibit generator
//

`timescale 1ns/1ns

module inhibit_gen_tb();

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
reg[7:0] discr_bits;
reg[31:0] inhibit_len;
wire[7:0] inhibit_bits;
wire[7:0] bits_out;
inhibit_generator_8b INHIBIT_GEN (
  .clk(lclk),
  .rst(rst),
  .bits_in(discr_bits),
  .inhibit_len(inhibit_len),
  .inhibit_bits(inhibit_bits),
  .bits_out(bits_out)
);

initial begin
  inhibit_len = 1;
  rst = 1;
  discr_bits = 0;
end

integer cnt = 0;
always @(posedge lclk) begin
  cnt <= cnt + 1;
  discr_bits <= 8'b0;

  if (cnt == 10) rst <= 0;

  if (cnt == 15) discr_bits <= 8'b1;
  if (cnt == 17) discr_bits <= 8'b10;
  if (cnt == 19) discr_bits <= 8'b100;
  if (cnt == 21) discr_bits <= 8'b1000;
  if (cnt == 23) discr_bits <= 8'b10000;
  if (cnt == 25) discr_bits <= 8'b100000;
  if (cnt == 27) discr_bits <= 8'b1000000;
  if (cnt == 29) discr_bits <= 8'b10000000;

  if (cnt == 31) discr_bits <= 8'b00000010;
  if (cnt == 32) discr_bits <= 8'b00010000;

  if (cnt == 35) begin
    inhibit_len <= 0;
  end
  if (cnt == 40) begin
    discr_bits <= 8'b10101010;
  end

  if (cnt == 45) begin
    inhibit_len <= 3;
  end

  if (cnt == 49) discr_bits <= 8'b10100100;

end

endmodule