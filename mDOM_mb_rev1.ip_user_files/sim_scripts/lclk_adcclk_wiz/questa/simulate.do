onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib lclk_adcclk_wiz_opt

do {wave.do}

view wave
view structure
view signals

do {lclk_adcclk_wiz.udo}

run -all

quit -force
