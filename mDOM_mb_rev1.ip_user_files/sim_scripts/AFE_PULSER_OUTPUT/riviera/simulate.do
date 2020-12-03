onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+AFE_PULSER_OUTPUT -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.AFE_PULSER_OUTPUT xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {AFE_PULSER_OUTPUT.udo}

run -all

endsim

quit -force
