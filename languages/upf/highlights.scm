; UPF domain-specific commands
(command
  name: (simple_word) @function.builtin
  (#any-of? @function.builtin
   "create_power_domain"
   "create_supply_port"
   "create_supply_net"
   "connect_supply_net"
   "set_domain_supply_net"
   "set_isolation"
   "set_retention"
   "set_level_shifter"
   "create_pst"
   "add_pst_state"
   "set_design_top"
   "add_power_state"
   "create_supply_set"
   "map_isolation_cell"
   "map_retention_cell"
   "map_level_shifter_cell"
   "use_interface_cell"))

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
