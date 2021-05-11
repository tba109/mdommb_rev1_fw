onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib FIFO_1024_16_opt

do {wave.do}

view wave
view structure
view signals

do {FIFO_1024_16.udo}

run -all

quit -force
