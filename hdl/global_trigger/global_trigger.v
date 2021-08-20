// 
// Generate a global discriminator-based trigger
//
// the source and reciever channels of the global trigger are configurable
// 
// The global trigger will occur one clock cycle later than the standard discriminator
// trigger would have
// 

module global_trigger #(parameter N_CHANNELS = 24,
                        parameter N_DISCR_BITS = 8)
(
  input clk,

  input[N_CHANNELS*N_DISCR_BITS-1:0] discr_stream,
  output reg[N_CHANNELS-1:0] trig_out = 0,

  // conf
  input enable,
  input trig_pol,
  input[N_CHANNELS-1:0] src_mask,
  input[N_CHANNELS-1:0] receiver_mask
);

reg[N_CHANNELS-1:0] i_rcv_mask = 0;
reg[N_CHANNELS-1:0] i_src_mask = 0;

wire[N_DISCR_BITS-1:0] discr_words[0:N_CHANNELS-1];
wire[N_CHANNELS-1:0] trigger_condition;
generate
  genvar i;
  for (i = 0; i < N_CHANNELS; i = i + 1) begin
    assign discr_words[i] = discr_stream[N_DISCR_BITS*(i+1) - 1 : N_DISCR_BITS*i];
    assign trigger_condition[i] = i_src_mask[i] && 
                                  ((trig_pol == 0 && (&discr_words[i] == 1'b0)) ||
                                   (trig_pol == 1 && (|discr_words[i] == 1'b1)));
  end
endgenerate

wire any_trig = |trigger_condition;
always @(posedge clk) begin
  if (!enable) begin 
    trig_out <= 0;
    i_rcv_mask <= 0;
    i_src_mask <= 0;
  end else begin 
    i_rcv_mask <= receiver_mask;
    i_src_mask <= src_mask;
    trig_out <= any_trig ? i_rcv_mask : 0;
  end
end

endmodule