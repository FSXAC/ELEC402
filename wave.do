onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Blue -radix ascii /test_fsm/current_test
add wave -noupdate -height 18 -group sys /test_fsm/DUT/clk
add wave -noupdate -height 18 -group sys /test_fsm/DUT/reset
add wave -noupdate -height 18 -expand -group {in btns} /test_fsm/DUT/power_btn
add wave -noupdate -height 18 -expand -group {in btns} /test_fsm/DUT/mode_inc
add wave -noupdate -height 18 -expand -group {in btns} /test_fsm/DUT/mode_dec
add wave -noupdate -height 18 -expand -group {in btns} /test_fsm/DUT/fstop_inc
add wave -noupdate -height 18 -expand -group {in btns} /test_fsm/DUT/fstop_dec
add wave -noupdate -height 18 -expand -group {in btns} /test_fsm/DUT/shutter_inc
add wave -noupdate -height 18 -expand -group {in btns} /test_fsm/DUT/shutter_dec
add wave -noupdate -height 18 -expand -group {in btns} /test_fsm/DUT/shutter_btn
add wave -noupdate -radix unsigned -childformat {{{/test_fsm/DUT/sensor_data[15]} -radix unsigned} {{/test_fsm/DUT/sensor_data[14]} -radix unsigned} {{/test_fsm/DUT/sensor_data[13]} -radix unsigned} {{/test_fsm/DUT/sensor_data[12]} -radix unsigned} {{/test_fsm/DUT/sensor_data[11]} -radix unsigned} {{/test_fsm/DUT/sensor_data[10]} -radix unsigned} {{/test_fsm/DUT/sensor_data[9]} -radix unsigned} {{/test_fsm/DUT/sensor_data[8]} -radix unsigned} {{/test_fsm/DUT/sensor_data[7]} -radix unsigned} {{/test_fsm/DUT/sensor_data[6]} -radix unsigned} {{/test_fsm/DUT/sensor_data[5]} -radix unsigned} {{/test_fsm/DUT/sensor_data[4]} -radix unsigned} {{/test_fsm/DUT/sensor_data[3]} -radix unsigned} {{/test_fsm/DUT/sensor_data[2]} -radix unsigned} {{/test_fsm/DUT/sensor_data[1]} -radix unsigned} {{/test_fsm/DUT/sensor_data[0]} -radix unsigned}} -subitemconfig {{/test_fsm/DUT/sensor_data[15]} {-radix unsigned} {/test_fsm/DUT/sensor_data[14]} {-radix unsigned} {/test_fsm/DUT/sensor_data[13]} {-radix unsigned} {/test_fsm/DUT/sensor_data[12]} {-radix unsigned} {/test_fsm/DUT/sensor_data[11]} {-radix unsigned} {/test_fsm/DUT/sensor_data[10]} {-radix unsigned} {/test_fsm/DUT/sensor_data[9]} {-radix unsigned} {/test_fsm/DUT/sensor_data[8]} {-radix unsigned} {/test_fsm/DUT/sensor_data[7]} {-radix unsigned} {/test_fsm/DUT/sensor_data[6]} {-radix unsigned} {/test_fsm/DUT/sensor_data[5]} {-radix unsigned} {/test_fsm/DUT/sensor_data[4]} {-radix unsigned} {/test_fsm/DUT/sensor_data[3]} {-radix unsigned} {/test_fsm/DUT/sensor_data[2]} {-radix unsigned} {/test_fsm/DUT/sensor_data[1]} {-radix unsigned} {/test_fsm/DUT/sensor_data[0]} {-radix unsigned}} /test_fsm/DUT/sensor_data
add wave -noupdate -height 18 -expand -group out -radix unsigned /test_fsm/DUT/output_data
add wave -noupdate -height 18 -expand -group out /test_fsm/DUT/output_data_valid
add wave -noupdate /test_fsm/DUT/power_on
add wave -noupdate -height 18 -expand -group aperture /test_fsm/DUT/aperture_setting_en
add wave -noupdate -height 18 -expand -group aperture /test_fsm/DUT/aperture_setting
add wave -noupdate -height 18 -expand -group aperture -radix unsigned /test_fsm/DUT/aperture_multiplier
add wave -noupdate -height 18 -expand -group shutter /test_fsm/DUT/shutter_setting_en
add wave -noupdate -height 18 -expand -group shutter /test_fsm/DUT/shutter_setting
add wave -noupdate -height 18 -expand -group shutter -radix unsigned /test_fsm/DUT/scd_cycles
add wave -noupdate -height 18 -expand -group states -color Magenta -height 32 /test_fsm/DUT/current_state
add wave -noupdate -height 18 -expand -group states -color Gray80 -itemcolor Gray80 /test_fsm/DUT/next_state
add wave -noupdate -height 18 -expand -group states /test_fsm/DUT/prev_mode_state
add wave -noupdate -height 18 -expand -group states /test_fsm/DUT/prev_mode_en
add wave -noupdate -height 18 -expand -group {shutter decode} /test_fsm/DUT/SHUTTER_DECODER/input_setting
add wave -noupdate -height 18 -expand -group {shutter decode} -radix decimal /test_fsm/DUT/SHUTTER_DECODER/shutter_wait_time
add wave -noupdate -height 18 -expand -group countdown /test_fsm/DUT/COUNTDOWN_MODULE/clk
add wave -noupdate -height 18 -expand -group countdown /test_fsm/DUT/COUNTDOWN_MODULE/reset
add wave -noupdate -height 18 -expand -group countdown -radix decimal /test_fsm/DUT/COUNTDOWN_MODULE/wait_cycles
add wave -noupdate -height 18 -expand -group countdown /test_fsm/DUT/COUNTDOWN_MODULE/write_enable
add wave -noupdate -height 18 -expand -group countdown /test_fsm/DUT/COUNTDOWN_MODULE/countdown_enable
add wave -noupdate -height 18 -expand -group countdown /test_fsm/DUT/COUNTDOWN_MODULE/done
add wave -noupdate -height 18 -expand -group countdown -radix decimal /test_fsm/DUT/COUNTDOWN_MODULE/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5578 ps} 0} {{Cursor 2} {787 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 183
configure wave -valuecolwidth 69
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {7808 ps}
