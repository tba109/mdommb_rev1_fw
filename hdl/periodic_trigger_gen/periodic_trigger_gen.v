// Aaron Fienberg
// December 2020
//
// Generates periodic triggers with a configurable frequency
//
// If period is < 2, output will be a constant 0
//

module periodic_trigger_gen (
  input clk,
  input rst,

  input[31:0] period,

  output reg trig = 0
);

reg[31:0] cnt = 0;
always @(posedge clk) begin
  if (rst || period < 2) begin
    trig <= 0;
    cnt <= 0;
  end

  else begin
    trig <= 0;
    cnt <= cnt + 1;

    if (cnt >= period - 1) begin
      cnt <= 0;
      trig <= 1;
    end
  end
end

endmodule