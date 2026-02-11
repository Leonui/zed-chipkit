;; Comments
(one_line_comment) @comment
(block_comment) @comment

;; Strings
(string_literal) @string
(quoted_string) @string
(system_lib_string) @string

;; Keywords
(["begin" "end" "this"]) @keyword
(["input" "output" "inout" "ref"]) @keyword
(["alias" "and" "assert" "assign" "assume" "before" "bind" "binsof" "break"
  "case" "checker" "class" "clocking" "config" "const" "constraint"
  "cover" "covergroup" "coverpoint" "cross" "default" "defparam" "disable"
  "do" "else" "endcase" "endchecker" "endclass" "endclocking" "endconfig"
  "endfunction" "endgenerate" "endgroup" "endinterface" "endmodule"
  "endpackage" "endprogram" "endproperty" "endsequence" "endtask" "enum"
  "extends" "extern" "final" "first_match" "for" "force" "foreach" "forever"
  "fork" "forkjoin" "function" "generate" "genvar" "if" "iff" "illegal_bins"
  "implements" "import" "initial" "inside" "interconnect" "interface"
  "intersect" "join" "join_any" "join_none" "local" "localparam" "matches"
  "modport" "new" "null" "option" "or" "package" "packed" "parameter"
  "program" "property" "pure" "randcase" "randomize" "release" "repeat"
  "return" "sequence" "showcancelled" "soft" "solve" "struct" "super" "tagged"
  "task" "timeprecision" "timeunit" "type" "typedef" "union" "unique"
  "virtual" "wait" "while" "with"
  (always_keyword)
  (bins_keyword)
  (case_keyword)
  (class_item_qualifier)
  (edge_identifier)
  (lifetime)
  (module_keyword)
  (random_qualifier)
  (unique_priority)]) @keyword

;; Preprocessor directives and macro usage
(["`include" "`define" "`ifdef" "`ifndef" "`timescale" "`default_nettype"
  "`elsif" "`undef" (resetall_compiler_directive) (undefineall_compiler_directive)
  "`endif" "`else" "`unconnected_drive" (celldefine_compiler_directive)
  (endcelldefine_compiler_directive) (endkeywords_directive) "`line"
  "`begin_keywords" "`pragma" "`__FILE__" "`__LINE__"]) @string.special
(text_macro_usage
 (simple_identifier) @string.special)

;; Delimiters, operators
([";" ":" "," "::"
  "=" "?" "|=" "&=" "^="
  "|->" "|=>" "->"
  ":=" ":/" "-:" "+:"]) @punctuation.delimiter
(["(" ")"]) @punctuation.bracket
(["[" "]"]) @punctuation.bracket
(["{" "}" "'{"]) @punctuation.bracket

(["."] @operator)
(["+" "-" "*" "/" "%" "**"]) @operator
(["<" "<=" ">" ">="]) @operator
(["===" "!==" "==" "!="]) @operator
(["&&" "||" "!"]) @operator
(["~" "&" "~&" "|" "~|" "^" "~^"]) @operator
(["<<" ">>" "<<<" ">>>"]) @operator
(["@" "#" "##"]) @operator
(assignment_operator) @operator
(unary_operator) @operator
(inc_or_dec_operator) @operator
(stream_operator) @operator
(event_trigger) @operator
(["->" "->>"]) @operator

;; Declarations - Module/interface/program/package/class/checker
(module_nonansi_header
 name: (simple_identifier) @function)
(module_ansi_header
 name: (simple_identifier) @function)
(interface_nonansi_header
 name: (simple_identifier) @function)
(interface_ansi_header
 name: (simple_identifier) @function)
(program_nonansi_header
 name: (simple_identifier) @function)
(program_ansi_header
 name: (simple_identifier) @function)
(package_declaration
 name: (simple_identifier) @function)
(class_declaration
 name: (simple_identifier) @function)
(interface_class_declaration
 name: (simple_identifier) @function)
(checker_declaration
 name: (simple_identifier) @function)
(class_declaration
 (class_type
  (simple_identifier) @type))

;; Function/task/methods
(function_body_declaration
 name: (simple_identifier) @function)
(task_body_declaration
 name: (simple_identifier) @function)
(function_prototype
 (data_type_or_void)
 name: (simple_identifier) @function)
(task_prototype
 name: (simple_identifier) @function)
(class_scope
 (class_type
  (simple_identifier)) @function)

;; Types
[(integer_vector_type)
  (integer_atom_type)
  (non_integer_type)
  (net_type)
  ["string" "event" "signed" "unsigned" "chandle"]] @type
(data_type_or_implicit
 (data_type
  (simple_identifier)) @type)
(data_type
 (class_type
  (simple_identifier) @type
  (parameter_value_assignment)))
(data_type
 (class_type
  (simple_identifier) @operator
  (simple_identifier) @type))
(net_port_header
 (net_port_type
  (simple_identifier) @type))
(variable_port_header
 (variable_port_type
  (data_type
   (simple_identifier) @type)))
(["void" (data_type_or_void)]) @type
(interface_port_header
 interface_name: (simple_identifier) @type
 modport_name: (simple_identifier) @type)
(type_assignment
 name: (simple_identifier) @type)
(net_declaration
 (simple_identifier) @type)
(enum_base_type
 (simple_identifier) @type)

;; Instances
(module_instantiation
 instance_type: (simple_identifier) @type)
(interface_instantiation
 instance_type: (simple_identifier) @type)
(program_instantiation
 instance_type: (simple_identifier) @type)
(checker_instantiation
 instance_type: (simple_identifier) @type)
(udp_instantiation
 instance_type: (simple_identifier) @type)
(name_of_instance
 instance_name: (simple_identifier) @constant)
(named_port_connection
 port_name: (simple_identifier) @constant)
(named_parameter_assignment
 (simple_identifier) @constant)

;; Numbers
(hex_number
 size: (unsigned_number) @number
 base: (hex_base) @punctuation.delimiter)
(decimal_number
 size: (unsigned_number) @number
 base: (decimal_base) @punctuation.delimiter)
(octal_number
 size: (unsigned_number) @number
 base: (octal_base) @punctuation.delimiter)
(binary_number
 size: (unsigned_number) @number
 base: (binary_base) @punctuation.delimiter)
(hex_number
 base: (hex_base) @punctuation.delimiter)
(decimal_number
 base: (decimal_base) @punctuation.delimiter)
(octal_number
 base: (octal_base) @punctuation.delimiter)
(binary_number
 base: (binary_base) @punctuation.delimiter)

;; Misc
((time_unit) @constant)
(enum_name_declaration
 (simple_identifier) @constant)
(attribute_instance
 (attr_spec (simple_identifier) @attribute))
(type_declaration
 type_name: (simple_identifier) @constant)

;; System tasks/functions
([(system_tf_identifier)
  "$fatal" "$error" "$warning" "$info"
  "$stop" "$finish" "$exit"])
@function.builtin

;; Errors
(ERROR) @error
