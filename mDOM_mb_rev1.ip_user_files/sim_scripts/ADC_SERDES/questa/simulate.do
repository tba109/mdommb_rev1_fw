onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ADC_SERDES_opt

do {wave.do}

view wave
view structure
view signals

do {ADC_SERDES.udo}

run -all

quit -force
