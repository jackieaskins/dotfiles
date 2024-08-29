; extends

(((property_signature) @_start @_end
  .
  [
    ","
    ";"
  ]? @_end)
  (#make-range! "range" @_start @_end))

(([
  (import_specifier)
  (enum_assignment)
] @_start @_end
  .
  ","? @_end)
  (#make-range! "range" @_start @_end))

([
  (export_statement)
  (import_statement)
  (import_clause)
] @_start @_end
  (#make-range! "range" @_start @_end))
