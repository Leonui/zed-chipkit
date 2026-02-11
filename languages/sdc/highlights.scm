; SDC domain-specific commands
(command
  name: (simple_word) @function.builtin
  (#any-of? @function.builtin
   "create_clock"
   "create_generated_clock"
   "set_clock_uncertainty"
   "set_input_delay"
   "set_output_delay"
   "set_false_path"
   "set_multicycle_path"
   "set_max_transition"
   "set_max_fanout"
   "set_max_delay"
   "set_min_delay"
   "set_clock_groups"
   "set_clock_latency"
   "set_propagated_clock"
   "group_path"
   "set_load"
   "set_driving_cell"
   "set_input_transition"
   "report_timing"
   "current_design"
   "set_units"
   "set_wire_load_model"))

; SDC query functions
(command
  name: (simple_word) @function
  (#any-of? @function
   "get_ports"
   "get_pins"
   "get_clocks"
   "get_cells"
   "get_nets"
   "get_lib_cells"
   "get_lib_pins"
   "all_inputs"
   "all_outputs"
   "all_clocks"
   "all_registers"))

(comment) @comment

(command name: (simple_word) @function)

"proc" @keyword

(procedure
  name: (_) @variable
)

(set (id) @variable)

(argument
  name: (_) @variable
)

"expr" @function

(command
  name: (simple_word) @function
  (#any-of? @function
   "cd"
   "exec"
   "exit"
   "incr"
   "info"
   "join"
   "puts"
   "regexp"
   "regsub"
   "split"
   "subst"
   "trace"
   "source"))

(command name: (simple_word) @keyword
         (#any-of? @keyword
          "append"
          "break"
          "catch"
          "continue"
          "default"
          "dict"
          "error"
          "eval"
          "global"
          "lappend"
          "lassign"
          "lindex"
          "linsert"
          "list"
          "llength"
          "lmap"
          "lrange"
          "lrepeat"
          "lreplace"
          "lreverse"
          "lsearch"
          "lset"
          "lsort"
          "package"
          "return"
          "trap"
          "throw"))

[
 "catch"
 "error"
 "global"
 "namespace"
 "on"
 "set"
 "try"
 "finally"
 ] @keyword

[
 "while"
 "foreach"
 ] @keyword

[
 "if"
 "else"
 "elseif"
 ] @keyword

[
 "**"
 "/" "*" "%" "+" "-"
 "<<" ">>"
 ">" "<" ">=" "<="
 "==" "!="
 "eq" "ne"
 "in" "ni"
 "&"
 "^"
 "|"
 "&&"
 "||"
 ] @operator

(unpack) @operator

(variable_substitution) @variable
(quoted_word) @string
(escaped_character) @string.escape

[
 "{" "}"
 "[" "]"
 ";"
 ] @punctuation.bracket

(number) @number

((simple_word) @number
               (#match? @number
                   "^[0-9]+$|^[+-]?[0-9]+$"))
