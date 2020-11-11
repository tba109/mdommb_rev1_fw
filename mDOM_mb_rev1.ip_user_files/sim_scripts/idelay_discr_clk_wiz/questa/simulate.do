onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib idelay_discr_clk_wiz_opt

do {wave.do}

view wave
view structure
view signals

do {idelay_discr_clk_wiz.udo}

run -all

quit -force
