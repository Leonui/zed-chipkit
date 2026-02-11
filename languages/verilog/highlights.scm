; Comments
(comment) @comment

; Strings
(double_quoted_string) @string

; Numbers
(integral_number) @number
(real_number) @number
(unsigned_number) @number
(time_literal) @number

; Types
(integer_atom_type) @type.builtin
(integer_vector_type) @type.builtin
(non_integer_type) @type.builtin

; Module name — via module_header (confirmed child of module_declaration)
(module_header (simple_identifier) @type)

; Interface name — interface_identifier IS a valid child of interface_declaration
(interface_declaration
  (interface_identifier (simple_identifier) @type))

; Function name — through function_body_declaration
(function_body_declaration
  (function_identifier (simple_identifier) @function))

; Task name — through task_body_declaration
(task_body_declaration
  (task_identifier (simple_identifier) @function))

; System tasks/functions ($display, $finish, etc.)
(system_tf_identifier) @function.builtin

; Parameters
(parameter_identifier (simple_identifier) @constant)

; Operators
(unary_operator) @operator
(assignment_operator) @operator
(inc_or_dec_operator) @operator

; Preprocessor directives — use specific directive types (no generic compiler_directive)
(text_macro_usage) @string.special
(text_macro_definition) @string.special
(include_compiler_directive) @string.special
(timescale_compiler_directive) @string.special
(default_nettype_compiler_directive) @string.special

; Keywords
[
  "module" "endmodule"
  "begin" "end"
  "if" "else"
  "for" "while" "repeat" "forever"
  "case" "casex" "casez" "endcase"
  "always"
  "initial"
  "assign" "deassign"
  "input" "output" "inout"
  "wire" "reg" "integer" "real" "time"
  "parameter" "localparam"
  "generate" "endgenerate"
  "function" "endfunction"
  "task" "endtask"
  "posedge" "negedge"
  "or" "and" "not"
  "defparam"
  "default"
  "disable"
  "force" "release"
  "fork" "join"
  "specify" "endspecify"
  "table" "endtable"
  "primitive" "endprimitive"
  "return"
] @keyword

; Punctuation
["(" ")" "[" "]" "{" "}"] @punctuation.bracket
[";" "," ":" "."] @punctuation.delimiter

; Identifiers (catch-all, lowest priority)
(simple_identifier) @variable
