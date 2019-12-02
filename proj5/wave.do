onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /test_fsm/DUT/output_data
add wave -noupdate /test_fsm/DUT/output_data_valid
add wave -noupdate /test_fsm/DUT/aperture_setting
add wave -noupdate /test_fsm/DUT/shutter_setting_output
add wave -noupdate /test_fsm/DUT/aperture_multiplier
add wave -noupdate /test_fsm/DUT/shutter_setting
add wave -noupdate /test_fsm/DUT/current_state
add wave -noupdate /test_fsm/DUT/power_on
add wave -noupdate /test_fsm/DUT/scd_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5588 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 281
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
