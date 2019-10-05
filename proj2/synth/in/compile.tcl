# This is a Tool Command Language file that tells
# the tool how to perform the synthesis

# This file is to be run from the "synth" folder as the root directory

puts "======================"
puts "| Synthesis Started! |"
puts "======================"

# Include TCL utility scripts
include load_etc.tcl

# Setup variables
set DESIGN fsm
set SYN_EFF medium
set MAP_EFF medium
set SYN_PATH "."
set PDKDIR $::env(PDKDIR)

# Set the search path for the library files
set_attribute lib_search_path $PDKDIR/gsclib045_all_v4.4/gsclib045/timing
set_attribute library {slow_vdd1v0_basicCells.lib}

# Read Verilog and RTL Code
read_hdl -sv ./in/countdown.sv
read_hdl -sv ./in/decoders.sv
read_hdl -sv ./in/dff.sv
read_hdl -sv ./in/div7.sv
read_hdl -sv ./in/fsm.sv

# Elaboration validates the syntax
elaborate $DESIGN

# Report the time and memory used
puts "Runtime and memory after reading HDL files:"
timestat Elaboration

# Output any problems with RTL code
check_design -unresolved

# Read in clock definition and timing constraints
read_sdc ./in/timing.sdc

# Synthesize to generic cell
synthesize -to_generic -eff $SYN_EFF
puts "Runtime and memory after synthesizing to generic cells:"
timestat GENERIC

# Synthesize to gates from the used PDK
synthesize -to_mapped -eff $MAP_EFF -no_incr
puts "Runtime and memory after synthesize to map:"
timestat MAPPED

# Incremental synthesis
synthesize -to_mapped -eff $MAPP_EFF -incr

# Insert tie hi and tie low cells
insert_tiehilo_cells
puts "Runtime and memory after incremental synthesis:"
timestat INCREMENTAL

# Generate report
report area > ./out/${DESIGN}_area.rpt
report gates > ./out/${DESIGN}_gates.rpt
report timing > ./out/${DESIGN}_timing.rpt
report power > ./out/${DESIGN}_power.rpt

# Generate output verilog with actual gates to be used in Encounter(TM) and ModelSim(TM)
write_hdl -mapped > ./out/${DESIGN}_map.sv

# Generate output constraint file to be used in Encounter(TM)
write_sdc > ./out/${DESIGN}_map.sdc

# Generate output delay file to be used in ModelSim(TM)
write_sdf > ./out/${DESIGN}_map.sdf

puts "Final runtime and memory used:"
timestat FINAL

# End
puts "================================"
puts "| Swentheswis Finuished UwU~~~ |"
puts "================================"

# Exit
quit






