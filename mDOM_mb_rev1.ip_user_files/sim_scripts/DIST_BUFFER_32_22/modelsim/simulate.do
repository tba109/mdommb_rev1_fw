onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L dist_mem_gen_v8_0_13 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.DIST_BUFFER_32_22 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {DIST_BUFFER_32_22.udo}

run -all

quit -force
