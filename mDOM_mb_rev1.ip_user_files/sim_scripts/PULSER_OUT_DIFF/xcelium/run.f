-makelib xcelium_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../mDOM_mb_rev1.srcs/sources_1/ip/PULSER_OUT_DIFF/PULSER_OUT_DIFF_selectio_wiz.v" \
  "../../../../mDOM_mb_rev1.srcs/sources_1/ip/PULSER_OUT_DIFF/PULSER_OUT_DIFF.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

