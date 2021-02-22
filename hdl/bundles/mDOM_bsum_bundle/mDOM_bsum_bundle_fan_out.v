module mDOM_bsum_bundle_fan_out
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

   input [44:0] bundle;
   output [0:0] pause;
   output [0:0] pause_override;
   output [2:0] sum_len_sel;
   output [15:0] pause_len;
   output [11:0] dev_low;
   output [11:0] dev_high;

assign pause = bundle[0:0];
assign pause_override = bundle[1:1];
assign sum_len_sel = bundle[4:2];
assign pause_len = bundle[20:5];
assign dev_low = bundle[32:21];
assign dev_high = bundle[44:33];

endmodule
