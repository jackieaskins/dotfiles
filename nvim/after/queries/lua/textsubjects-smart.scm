; extends

([
  (variable_declaration)
  (return_statement)
  (assignment_statement)
] @_start @_end
  (#make-range! "range" @_start @_end))
