onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DISCR_SERDES_opt

do {wave.do}

view wave
view structure
view signals

do {DISCR_SERDES.udo}

run -all

quit -force
