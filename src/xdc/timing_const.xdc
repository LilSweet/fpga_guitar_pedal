create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {INCLK}]; #12MHz input clock