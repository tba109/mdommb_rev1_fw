//
// Counts positive edges of an input signal
// 
// continues counting until being reset or disabled
// 
// Aaron Fienberg
// April 2021
//

module posedge_counter (
  input clk,
  input rst,

  input en, // enable
  
  input in,
  output reg[15:0] cnt = 16'b0
);

wire in_pe;
posedge_detector PEDGE(.clk(clk), .rst_n(!rst), .a(in), .y(in_pe));

always @(posedge clk) begin
  if (rst || !en) begin
    cnt <= 16'h0;
  end else begin
    if (in_pe && cnt < 16'hffff) begin
      cnt <= cnt + 1'b1;
    end
  end
end

endmodule