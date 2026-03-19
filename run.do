if {[file exists work]} {
    vdel -lib work -all
}

vlib work
vlog traffic_light_fsm.sv
vlog traffic_light_fsm_tb.sv

vsim -voptargs=+acc work.traffic_light_fsm_tb

view wave
add wave -r /*

run 24000ns
