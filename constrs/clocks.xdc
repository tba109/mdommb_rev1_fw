# clocks and timing constraints

create_clock -name fpga_clk -period 50.000 [get_ports {FPGA_CLOCK_P}]
create_clock -name qosc_clk -period 50.000 [get_ports {QOSC_CLK_P1V8}]

# DDR input constraints are described in the following Xilinx forum thread
# https://forums.xilinx.com/t5/Timing-Analysis/How-to-constraint-Same-Edge-capture-edge-aligned-DDR-input/m-p/646009#M8411
# however, these seem to apply to source synchronous interfaces, which we won't be using in the mDOM
# instead, we'll run all SERDES off of a single clock inside the FPGA

# ATF todo: work out these constraints

# Below I'll try to define some reasonable constraints given this situation

# 375 MHz launch clock
# create_clock -name virt_clk -period 2.667

# setup and hold from datasheet page 17:
# https://www.ti.com/lit/ds/symlink/adc3424.pdf?ts=1593536289216&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FADC3424
# t_su = 0.43 ns
# t_h = 0.48 ns
# The above are the specs at 125 MHz, which we may want to use
# max delay: UI/2 - setup time
#set_input_delay -clock virt_clk 0.237 [get_ports ADC*_D*]
# min delay: -UI/2 + hold time
#set_input_delay -clock virt_clk -0.187 -min [get_ports ADC*_D*]

#set_input_delay -clock virt_clk 0.237 [get_ports ADC*_D*] -clock_fall -add_delay
#set_input_delay -clock virt_clk -0.187 -min [get_ports ADC*_D*] -clock_fall -add_delay

# tell Vivado that virt_clk and master_clk_wiz_outclk3 are asynchronous
# https://forums.xilinx.com/t5/Vivado-TCL-Community/How-to-set-timing-constraint-in-this-case/td-p/510641