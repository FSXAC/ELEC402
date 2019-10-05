onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_fsm/clk
add wave -noupdate /test_fsm/reset
add wave -noupdate /test_fsm/power_btn
add wave -noupdate /test_fsm/mode_inc
add wave -noupdate /test_fsm/mode_dec
add wave -noupdate /test_fsm/fstop_inc
add wave -noupdate /test_fsm/fstop_dec
add wave -noupdate /test_fsm/shutter_inc
add wave -noupdate /test_fsm/shutter_dec
add wave -noupdate /test_fsm/shutter_btn
add wave -noupdate -radix unsigned /test_fsm/sensor_data
add wave -noupdate -radix unsigned /test_fsm/fsm_output
add wave -noupdate /test_fsm/fsm_output_valid
add wave -noupdate -radix ascii /test_fsm/current_test
add wave -noupdate /test_fsm/DUT/aperture_setting
add wave -noupdate /test_fsm/DUT/shutter_setting
add wave -noupdate -radix unsigned /test_fsm/DUT/current_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1339 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 189
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {5904 ps}
