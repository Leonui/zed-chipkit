; Punctuation
["(" ")" "[" "]" "{" "}"] @punctuation.bracket

; Numbers
(number) @number
(character) @constant
(boolean) @constant

; Symbols (identifiers)
(symbol) @variable

; Strings
(string) @string
(escape_sequence) @string.escape

; Function calls - first symbol in a list
(list
  .
  (symbol) @function)

; Operators
((symbol) @operator
 (#match? @operator "^(\\+|-|\\*|/|=|>|<|>=|<=)$"))

; Keywords - SKILL/Scheme control flow
(list
  .
  (symbol) @keyword
  (#match? @keyword
   "^(procedure|let|lambda|case|define|cond|set!|setq|letrec|do|else|begin|quote|and|if|or|when|unless|foreach|for|while|return|prog|defun|defmacro|caar|cadr|cdar|cddr|car|cdr|cons|list|printf|sprintf|fprintf|println|load|require)$"
   ))

; Quoted expressions
(quote
  _ @constant)
(quote
  (_ _* @constant))

; Comments
[(comment)
 (block_comment)
 (directive)] @comment
