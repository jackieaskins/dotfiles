; extends

([
  (variable_declaration)
  (return_statement)
  (assignment_statement)
  value: (_)
] @_start @_end
  (#make-range! "range" @_start @_end))
