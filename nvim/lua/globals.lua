function Print(...)
  local inspect_types = { 'thread', 'userdata', 'table', 'function' }
  local mapped_args = vim.tbl_map(function(arg)
    return vim.tbl_contains(inspect_types, type(arg)) and vim.inspect(arg) or arg
  end, { ... })
  print(unpack(mapped_args))
end
