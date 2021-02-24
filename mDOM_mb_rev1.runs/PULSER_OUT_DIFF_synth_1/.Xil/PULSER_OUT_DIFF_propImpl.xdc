set_property SRC_FILE_INFO {cfile:c:/Users/atfie/IceCube/mDOMDevelopment/mdommb_rev1_fw/mDOM_mb_rev1.srcs/sources_1/ip/PULSER_OUT_DIFF/PULSER_OUT_DIFF_ooc.xdc rfile:../../../mDOM_mb_rev1.srcs/sources_1/ip/PULSER_OUT_DIFF/PULSER_OUT_DIFF_ooc.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:56 export:INPUT save:INPUT read:FILTER_OUT_OF_CONTEXT} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.1
