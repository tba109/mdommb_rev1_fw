//
// Detects samples that deviate by a configurable number of
// ADC counts from the rolling baseline sum
//
// Outputs a trigger signal, delayed by one clock cycle, which
// can be used to pause the rolling sum
//
// when the threshold is 0, no check is conducted (all samples are considered in range)
//
// Aaron Fienberg
// April 2020
//
// Adapted for mDOM, Feb. 2021

module deviation_detector #(parameter SAMPLEBITS = 12,
                            parameter SUMBITS = 19,
                            parameter SHIFTBITS = 3)
 (
   // signal inputs
   input clk,
   input rst_n,
   input [SAMPLEBITS-1:0] d_in,
   input [SUMBITS-1:0]    sum_in,
   input [SHIFTBITS-1:0]  sum_len_sel,
   input sum_valid,
   // parameter inputs
   input[SAMPLEBITS-1:0] low_thresh,
   input[SAMPLEBITS-1:0] high_thresh,
   // output
   output reg trig = 0
 );

 wire[SAMPLEBITS-1:0] avg_bline = sum_in >> sum_len_sel;

 wire[SAMPLEBITS:0] low_sum = d_in + low_thresh;
 wire[SAMPLEBITS:0] high_sum = high_thresh + avg_bline;
 wire low_check = (low_thresh == 0) || (low_sum > avg_bline);
 wire high_check = (high_thresh == 0) || (high_sum > d_in);


 always @(posedge clk) begin
   if (!rst_n || !sum_valid) begin
     trig <= 0;
   end

   else begin
     // triggers when the checks fail (sample out of range)
     trig <= !low_check || !high_check;
   end
 end


endmodule
