// Aaron Fienberg
//
// Test bench for the posedge_counter
//

`timescale 1ns/1ns

module posedge_counter_tb();

parameter CLK_PERIOD = 10;
reg clk;
initial begin
  // clock initialization        
  clk = 1'b0;    
end

// clock driver
always @(clk)
  #(CLK_PERIOD / 2.0) clk <= !clk;

reg rst = 1'b1;
reg en = 1'b0;
reg in = 1'b0;
wire[15:0] out;

posedge_counter counter (
  .clk(clk),
  .rst(rst),
  .en(en),
  .in(in),
  .cnt(out)
);

integer cnt = 0;

always @(posedge clk) begin
  cnt <= cnt + 1;
  in <= 0;

  if (cnt == 9) begin
    rst <= 0;
  end
  
  if (cnt == 14) begin
    en <= 1;
  end

  if (cnt == 19 || cnt == 20) begin
    in <= 1;
  end

  if (cnt == 23) begin
    in <= 1;
  end

  if (cnt == 25) begin
    in <= 1;
  end

  if (cnt == 29) begin
    en <= 0;
  end
  
  if (cnt == 31) begin
      en <= 1;
  end
  
  if (cnt == 33) begin
      in <= 1;
  
  end
  if (cnt == 35) begin
      in <= 1;
  end

end

endmodule