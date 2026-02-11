; CPF domain-specific commands
(command
  name: (simple_word) @function.builtin
  (#any-of? @function.builtin
   "set_design"
   "set_scope"
   "create_power_nets"
   "create_ground_nets"
   "create_power_domain"
   "create_nominal_condition"
   "create_power_mode"
   "create_isolation_rule"
   "create_level_shifter_rule"
   "create_state_retention_rule"
   "set_cpf_version"
   "set_instance"
   "update_power_domain"
   "create_global_connection"
   "end_design"))

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
