onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk /test_fsm/clk
add wave -noupdate -label reset /test_fsm/reset
add wave -noupdate -label power_btn /test_fsm/power_btn
add wave -noupdate -label mode_inc /test_fsm/mode_inc
add wave -noupdate -label mode_dec /test_fsm/mode_dec
add wave -noupdate -label fstop_inc /test_fsm/fstop_inc
add wave -noupdate -label fstop_dec /test_fsm/fstop_dec
add wave -noupdate -label shutter_inc /test_fsm/shutter_inc
add wave -noupdate -label shutter_dec /test_fsm/shutter_dec
add wave -noupdate -label shutter_btn /test_fsm/shutter_btn
add wave -noupdate -label sensor_data -radix unsigned /test_fsm/sensor_data
add wave -noupdate -label output -radix unsigned /test_fsm/fsm_output
add wave -noupdate -label output_valid /test_fsm/fsm_output_valid
add wave -noupdate -color Blue -label current_test -radix ascii -radixshowbase 0 /test_fsm/current_test
add wave -noupdate -color Magenta -label state /test_fsm/DUT/current_state
add wave -noupdate -label aperture_setting /test_fsm/DUT/aperture_setting
add wave -noupdate -label shutter_setting /test_fsm/DUT/shutter_setting
add wave -noupdate -label SCD_Cycles -radix unsigned /test_fsm/DUT/scd_cycles
add wave -noupdate -label SCD_done /test_fsm/DUT/scd_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3238 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 181
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
WaveRestoreZoom {2614 ps} {5744 ps}
