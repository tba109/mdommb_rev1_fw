module mDOM_bsum_bundle_fan_in
  (
   bundle,
   pause,
   pause_override,
   sum_len_sel,
   pause_len,
   dev_low,
   dev_high
  );

`include "mDOM_bsum_bundle_inc.v"

   output [44:0] bundle;
   input [0:0] pause;
   input [0:0] pause_override;
   input [2:0] sum_len_sel;
   input [15:0] pause_len;
   input [11:0] dev_low;
   input [11:0] dev_high;

assign bundle[0:0] = pause;
assign bundle[1:1] = pause_override;
assign bundle[4:2] = sum_len_sel;
assign bundle[20:5] = pause_len;
assign bundle[32:21] = dev_low;
assign bundle[44:33] = dev_high;


endmodule
