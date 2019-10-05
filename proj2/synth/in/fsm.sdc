# The is a file that specifies the timing constraints of our design

# Use `current_design` to specify the top level module name
current_design fsm

# Use `create_clock` to create a clock and wire them to the corresponding signals
create_clock [get_ports{clk}] -name clk -period 100 -waveform{0 50}
