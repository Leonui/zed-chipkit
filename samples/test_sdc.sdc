# SDC sample — LSP diagnostics & formatting demo
# Open in Zed with ChipKit + tclsp to see tclint in action.
#
# What to try:
#   1. Check the Problems panel for lint diagnostics
#   2. Run "Format Document" to fix indentation
#   3. SDC is Tcl syntax — tclsp provides full linting

# ── Clock definitions ──────────────────────────────────────────
current_design top_chip
create_clock -name SYS_CLK -period 10.0 [get_ports clk]
create_clock -name JTAG_CLK -period 100.0 [get_ports tck]
create_generated_clock -name DIV_CLK \
  -source [get_pins clk_div/clk_in] \
  -divide_by 2 \
  [get_pins clk_div/clk_out]

# ── Messy indentation — formatter cleans this up ───────────────
set_clock_uncertainty 0.15 -setup [get_clocks SYS_CLK]
  set_clock_uncertainty 0.05 -hold [get_clocks SYS_CLK]
    set_clock_transition 0.08 [get_clocks SYS_CLK]

# ── Input/output constraints ──────────────────────────────────
set all_inputs [remove_from_collection [all_inputs] [get_ports {clk tck}]]
set_input_delay 2.0 -clock SYS_CLK $all_inputs
set_output_delay 1.5 -clock SYS_CLK [all_outputs]

# ── Unbraced expr — tclint flags this ─────────────────────────
set margin 0.5
set effective_period [expr 10.0 - $margin * 2]

# ── False paths and multicycle ─────────────────────────────────
set_false_path -from [get_clocks JTAG_CLK] -to [get_clocks SYS_CLK]
set_false_path -from [get_clocks SYS_CLK]  -to [get_clocks JTAG_CLK]

set_multicycle_path 2 -setup \
  -from [get_pins {slow_reg_*/clk}] \
  -to   [get_pins {slow_reg_*/D}]
set_multicycle_path 1 -hold \
  -from [get_pins {slow_reg_*/clk}] \
  -to   [get_pins {slow_reg_*/D}]

# ── Design rule constraints ────────────────────────────────────
set_max_transition 0.25 [current_design]
set_max_fanout 32 [current_design]
set_max_capacitance 0.5 [all_outputs]

# ── Reporting ──────────────────────────────────────────────────
report_timing -max_paths 20 -sort_by slack
report_clock_timing -type summary
