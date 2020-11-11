onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+idelay_discr_clk_wiz -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.idelay_discr_clk_wiz xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {idelay_discr_clk_wiz.udo}

run -all

endsim

quit -force
