# Tcl sample
namespace eval demo {
  variable clk_period 10.0

  proc report_clock {name period} {
    if {$period > 0} {
      puts "Clock $name period = $period"
    } else {
      puts "Invalid period"
    }
  }
}

set design_name top
set cells [list U1 U2 U3]
foreach c $cells {
  puts "Cell: $c"
}
