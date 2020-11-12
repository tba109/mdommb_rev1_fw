// Aaron Fienberg
// November 2020
//
// Input for one ADC channel and one discriminator
//

module adc_discr_channel
  (
   input[1:0] adc_DP,
   input[1:0] adc_DN,
   input discr_out,
   input lclk,
   input discr_fclk,
   input adc_dclk,
   input discr_dclk,

   input[1:0] in_delay_reset,
   input[1:0] in_delay_data_ce,
   input[1:0] in_delay_data_inc,
   input[1:0] adc_bitslip,
   input[1:0] adc_io_reset,

   input discr_bitslip,
   input discr_io_reset,

   output reg[11:0] adc_bits = 0,
   output reg[7:0]  discr_bits = 0,

   input[4:0] delay_tap_in_0,
   input[4:0] delay_tap_in_1,

   output[4:0] delay_tap_out_0,
   output[4:0] delay_tap_out_1
  );

  wire[5:0] adc_bits_0;
  ADC_SERDES ADC_SERDES_0
   (
     .data_in_from_pins_p(adc_DP[0]),
     .data_in_from_pins_n(adc_DN[0]),
     .data_in_to_device(adc_bits_0),
     .in_delay_reset(in_delay_reset[0]),
     .in_delay_data_ce(in_delay_data_ce[0]),
     .in_delay_data_inc(in_delay_data_inc[0]),
     .in_delay_tap_in(delay_tap_in_0),
     .in_delay_tap_out(delay_tap_out_0),
     .bitslip(adc_bitslip[0]),
     .clk_in(adc_dclk),
     .clk_div_in(lclk),
     .io_reset(adc_io_reset[0])
   );

  wire[5:0] adc_bits_1;
  ADC_SERDES ADC_SERDES_1
   (
     .data_in_from_pins_p(adc_DP[1]),
     .data_in_from_pins_n(adc_DN[1]),
     .data_in_to_device(adc_bits_1),
     .in_delay_reset(in_delay_reset[1]),
     .in_delay_data_ce(in_delay_data_ce[1]),
     .in_delay_data_inc(in_delay_data_inc[1]),
     .in_delay_tap_in(delay_tap_in_1),
     .in_delay_tap_out(delay_tap_out_1),
     .bitslip(adc_bitslip[1]),
     .clk_in(adc_dclk),
     .clk_div_in(lclk),
     .io_reset(adc_io_reset[1])
   );
  wire[11:0] i_adc_bits_0 = {adc_bits_1, adc_bits_0};

  wire[7:0] i_discr_bits_0;
  DISCR_SERDES DISCR_SERDES
  (
   .data_in_from_pins(discr_out),
   .data_in_to_device(i_discr_bits_0),
   .bitslip(discr_bitslip),
   .clk_in(discr_dclk),
   .clk_div_in(discr_fclk),
   .io_reset(discr_io_reset)
  );

  reg[11:0] i_adc_bits_1 = 0;
  reg[7:0] i_discr_bits_1 = 0;
  always @(posedge lclk) begin
    i_adc_bits_1 <= i_adc_bits_0;
    adc_bits <= i_adc_bits_1;
    discr_bits <= i_discr_bits_1;
  end

  always @(posedge discr_fclk) begin
    i_discr_bits_1 <= i_discr_bits_0;
  end

endmodule