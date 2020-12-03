onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib AFE_PULSER_OUTPUT_opt

do {wave.do}

view wave
view structure
view signals

do {AFE_PULSER_OUTPUT.udo}

run -all

quit -force
