# SDC sample
current_design top
create_clock -name CLK -period 10 [get_ports clk]
set_clock_uncertainty 0.1 [get_clocks CLK]
set_input_delay 1.2 -clock CLK [get_ports data_in*]
set_output_delay 1.5 -clock CLK [get_ports data_out*]
set_false_path -from [get_clocks CLK] -to [get_pins U_DEBUG/*]
set_multicycle_path 2 -setup -from [get_clocks CLK] -to [get_clocks CLK]
set_max_transition 0.2 [current_design]
report_timing -max_paths 10
