onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DIST_BUFFER_128_12_opt

do {wave.do}

view wave
view structure
view signals

do {DIST_BUFFER_128_12.udo}

run -all

quit -force
