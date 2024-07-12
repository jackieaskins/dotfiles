([
  ; Svelte elements
  (element)
  (script_element)
  (style_element)
  (attribute)
  ; Logic blocks
  (await_statement)
  (then_block)
  (catch_block)
  (each_statement)
  (if_statement)
  (else_if_block)
  (else_block)
  (key_statement)
] @_start @_end
  (#make-range! "range" @_start @_end))
