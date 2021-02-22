// Extends an input pulse by 'extend_len' clock cycles
//
// if "in" pulses again during the extension window,
// the extension counter will start over 
//
// "in" is assumed to be externally synchronized with clk
//
// Aaron Fienberg
// September 2019
//
// Updated April 2020 to make extend_len dynamically configurable

module pulse_extender #(parameter P_N_WIDTH = 32) (
	input clk,
	input reset_n,
	input in,  // input pulse
	input[P_N_WIDTH-1:0] extend_len,
	output out // output data
	);

reg hold_high = 0;

assign out = in | hold_high; 

localparam S_IDLE = 0,
           S_HIGH = 1,
           S_HOLD = 2;
reg[1:0] fsm = S_IDLE;

reg[31:0] counter = 0;

always @(posedge clk) begin
	if (!reset_n) begin
	  fsm <= S_IDLE;
	  counter <= 0;
	  hold_high <= 0;
	end

	else begin
	  case (fsm)
	    S_IDLE: begin
	      counter <= 0;
	      hold_high <= 0;
	      if (in && extend_len > 0) begin
	        hold_high <= 1;
	        fsm <= S_HIGH;
	      end
	      else fsm <= S_IDLE;
	    end

	    S_HIGH: begin
	      counter <= 0;
	      hold_high <= 1;

	      if (!in) begin
	        if (extend_len > 1) fsm <= S_HOLD;
	        else begin
	          hold_high <= 0;
	          fsm <= S_IDLE;
	        end
	      end

	    end

	    S_HOLD: begin
	      counter <= counter + 1;
	      hold_high <= 1;
	      if (in) begin
	      	fsm <= S_HIGH;
	      end
	      else if (counter >= extend_len - 2) begin
	      	hold_high <= 0;
	      	fsm <= S_IDLE;
	      end
	    end	 

	    default: begin
	      fsm <= S_IDLE;
	      hold_high <= 0;
	      counter <= 0;
	    end   
	    
	  endcase
	end
end

endmodule	                       