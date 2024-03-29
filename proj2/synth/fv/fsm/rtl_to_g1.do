// Generated by Cadence Encounter(R) RTL Compiler RC14.13 - v14.10-s027_1
tclmode
set env(RC_VERSION) "RC14.13 - v14.10-s027_1"
vpxmode
set dofile abort exit
usage -auto -elapse
set log file fv/fsm/rtl_to_g1.log -replace
tclmode
set ver [lindex [split [lindex [get_version_info] 0] "-"] 0]
vpxmode
tclmode
set env(CDN_SYNTH_ROOT) /CMC/tools/cadence/RC14.13.000_lnx86/tools
set CDN_SYNTH_ROOT /CMC/tools/cadence/RC14.13.000_lnx86/tools
vpxmode
tclmode
if {$ver >= 08.10} {
  vpx set naming style rc
}
vpxmode
set naming rule "%s[%d]" -instance_array
set naming rule "%s_reg" -register -golden
set naming rule "%L.%s" "%L[%d].%s" "%s" -instance
set naming rule "%L.%s" "%L[%d].%s" "%s" -variable
set undefined cell black_box -noascend -both
set undriven signal Z -golden

add search path -library /CMC/kits/AMSKIT616_GPDK/tech/gsclib045_all_v4.4/gsclib045/timing
read library -statetable -liberty -both  \
	slow_vdd1v0_basicCells.lib

add search path -design .
tclmode
if {$ver < 13.10} {
vpx read design -enumconstraint -systemverilog  -define SYNTHESIS  -golden -lastmod -noelab \
	in/countdown.sv
} else {
vpx read design -enumconstraint -systemverilog  -define SYNTHESIS  -merge bbox -golden -lastmod -noelab \
	in/countdown.sv
}
vpxmode

add search path -design .
tclmode
if {$ver < 13.10} {
vpx read design -enumconstraint -systemverilog  -define SYNTHESIS  -golden -lastmod -noelab \
	in/decoders.sv
} else {
vpx read design -enumconstraint -systemverilog  -define SYNTHESIS  -merge bbox -golden -lastmod -noelab \
	in/decoders.sv
}
vpxmode

add search path -design .
tclmode
if {$ver < 13.10} {
vpx read design -enumconstraint -systemverilog  -define SYNTHESIS  -golden -lastmod -noelab \
	in/dff.sv
} else {
vpx read design -enumconstraint -systemverilog  -define SYNTHESIS  -merge bbox -golden -lastmod -noelab \
	in/dff.sv
}
vpxmode

add search path -design .
tclmode
if {$ver < 13.10} {
vpx read design -enumconstraint -systemverilog  -define SYNTHESIS  -golden -lastmod -noelab \
	in/fsm.sv
} else {
vpx read design -enumconstraint -systemverilog  -define SYNTHESIS  -merge bbox -golden -lastmod -noelab \
	in/fsm.sv
}
vpxmode

elaborate design -golden -root fsm -rootonly

tclmode
if {$ver < 13.10} {
vpx read design -verilog -revised -lastmod -noelab \
	-unzip fv/fsm/g1.v.gz
} else {
vpx read design -verilog95 -revised -lastmod -noelab \
	-unzip fv/fsm/g1.v.gz
}
vpxmode

elaborate design -revised -root fsm

tclmode
set ver [lindex [split [lindex [get_version_info] 0] "-"] 0]
if {$ver < 13.10} {
vpx substitute blackbox model -golden
}
vpxmode
report design data
report black box

uniquify -all -nolib
set flatten model -seq_constant -seq_constant_x_to 0
set flatten model -nodff_to_dlat_zero -nodff_to_dlat_feedback
// set parallel option -threads 4 -license xl -norelease_license
// set compare options -threads 0
set analyze option -auto

write hier_compare dofile fv/fsm/hier_rtl_to_g1.do \
	-noexact_pin_match -constraint -usage -replace -balanced_extraction -input_output_pin_equivalence \
	-prepend_string "analyze datapath -module -verbose; usage; analyze datapath -verbose"
run hier_compare fv/fsm/hier_rtl_to_g1.do -analyze_abort  -dynamic_hierarchy
// report hier_compare result -dynamicflattened
set system mode lec
tclmode
puts "No of diff points    = [get_compare_points -NONequivalent -count]"
if {[get_compare_points -NONequivalent -count] > 0} {
    puts "------------------------------------"
    puts "ERROR: Different Key Points detected"
    puts "------------------------------------"
#     foreach i [get_compare_points -NONequivalent] {
#         vpx report test vector [get_keypoint $i]
#         puts "     ----------------------------"
#     }
}
vpxmode
exit -force
