
`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Test cases
//////////////////////////////////////////////////////////////////////////////////
`define TEST_CASE_1

module local_coincidence_tb;
   
   //////////////////////////////////////////////////////////////////////
   // I/O
   //////////////////////////////////////////////////////////////////////   
   parameter CLK_PERIOD = 10.0;
   reg clk;
   reg rst;

   localparam N_CHANNELS = 24; 
   
   // Connections
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [N_CHANNELS-1:0] local_coinc;		// From UUT_0 of local_coincidence.v
   // End of automatics
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [15:0]		lc_window_width;	// To UUT_0 of local_coincidence.v
   reg [15:0]		n_lc_thr;		// To UUT_0 of local_coincidence.v
   reg [N_CHANNELS-1:0]	trig;			// To UUT_0 of local_coincidence.v
   // End of automatics
   
   //////////////////////////////////////////////////////////////////////
   // Clock Driver
   //////////////////////////////////////////////////////////////////////
   always @(clk)
     #(CLK_PERIOD / 2.0) clk <= !clk;
				   
   //////////////////////////////////////////////////////////////////////
   // Simulated interfaces
   //////////////////////////////////////////////////////////////////////   
      
   //////////////////////////////////////////////////////////////////////
   // UUT
   //////////////////////////////////////////////////////////////////////   
   local_coincidence UUT_0(/*AUTOINST*/
			   // Outputs
			   .local_coinc		(local_coinc[N_CHANNELS-1:0]),
			   // Inputs
			   .clk			(clk),
			   .rst			(rst),
			   .lc_window_width	(lc_window_width[15:0]),
			   .n_lc_thr		(n_lc_thr[15:0]),
			   .trig		(trig[N_CHANNELS-1:0])); 
   
   //////////////////////////////////////////////////////////////////////
   // Testbench
   //////////////////////////////////////////////////////////////////////   
   initial
     begin
	// Initializations
	clk = 1'b0;
	rst = 1'b1;
     end

   //////////////////////////////////////////////////////////////////////
   // Test case
   //////////////////////////////////////////////////////////////////////   
`ifdef TEST_CASE_1
   integer i; 
   initial
     begin
	i = 0;
	lc_window_width = 9;
	n_lc_thr = 4;
	trig = 24'b0; 

	// Reset	
	#(10 * CLK_PERIOD);
	rst = 1'b0;
	#(20* CLK_PERIOD);

	// Logging
	$display("");
	$display("------------------------------------------------------");
	$display("Test Case: TEST_CASE_1");

	$display("Shifting a 1 through every bit position\n"); 
	for(i=0; i<N_CHANNELS; i=i+1)
	  begin
	     if(i==0)
	       begin @(posedge clk) #1; trig = 1; end
	     else
	       begin @(posedge clk) #1; trig = {trig[N_CHANNELS-2:0],1'b0}; end
	  end

	for(i=0; i<100; i=i+1)
	  begin
	     @(posedge clk) #1; 
	  end
	
	@(posedge clk) #1; trig = 0; 
    
     end

   

   `endif

   //////////////////////////////////////////////////////////////////////
   // Tasks (e.g., writing data, etc.)
   //////////////////////////////////////////////////////////////////////   
   
   
   
endmodule

// Local Variables:
// verilog-library-flags:("-y ../")
// End:
   
