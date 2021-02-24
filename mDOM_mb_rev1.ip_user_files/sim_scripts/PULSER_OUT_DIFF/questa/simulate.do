onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib PULSER_OUT_DIFF_opt

do {wave.do}

view wave
view structure
view signals

do {PULSER_OUT_DIFF.udo}

run -all

quit -force
