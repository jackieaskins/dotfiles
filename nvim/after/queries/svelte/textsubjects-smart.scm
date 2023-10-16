(([
  ; Svelte elements
  (element)
  (script_element)
  (style_element)
  (attribute)

  ; Logic blocks
  (await_statement)
  (then_statement)
  (catch_statement)

  (each_statement)

  (if_statement)
  (else_if_statement)
  (else_statement)

  (key_statement)

  ; Special tags
  (const_expr)
  (html_expr)
] @_start @_end)
(#make-range! "range" @_start @_end))
