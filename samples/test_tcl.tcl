# Tcl sample — LSP diagnostics & formatting demo
# Open in Zed with ChipKit + tclsp to see tclint in action.
#
# What to try:
#   1. Check the Problems panel for lint diagnostics
#   2. Run "Format Document" to fix indentation
#   3. Hover over commands for documentation

# ── Inconsistent indentation — tclsp formatter fixes this ─────
proc read_config {filename} {
    set fp [open $filename r]
        set data [read $fp]
      close $fp
          return $data
}

# ── expr without braces — tclint flags this ────────────────────
# Unbraced expr is slower and can be a security risk.
set a 10
set b 20
set result [expr {$a + $b}]

# ── Namespace with procs — shows in symbol outline ─────────────
namespace eval ::chip::utils {
  variable verbose 0

  proc log {level msg} {
    variable verbose
    if {$verbose || $level eq "error"} {
        puts stderr "\[$level\] $msg"
    }
  }

    proc parse_netlist {file_path} {
      set nets [list]
        set fp [open $file_path r]
      while {[gets $fp line] >= 0} {
            if {[regexp {^net\s+(\S+)} $line -> name]} {
          lappend nets $name
            }
      }
        close $fp
      return $nets
    }
}

# ── Command substitution style — tclint may flag ──────────────
set design_name "top_chip"
set report_dir "/tmp/${design_name}_reports"
file mkdir $report_dir

set cells [list BUF_X1 INV_X2 AND2_X1 OR2_X1]
foreach cell $cells {
set count [llength [get_refs -of $cell]]
    puts "Cell $cell: $count instances"
}
