onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+PULSER_OUT_DIFF -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.PULSER_OUT_DIFF xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {PULSER_OUT_DIFF.udo}

run -all

endsim

quit -force
