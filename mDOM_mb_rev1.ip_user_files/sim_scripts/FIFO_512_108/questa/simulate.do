onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib FIFO_512_108_opt

do {wave.do}

view wave
view structure
view signals

do {FIFO_512_108.udo}

run -all

quit -force
