local M = {}

function M.get_status()
  local status = {}

  local current_function = vim.b.lsp_current_function
  if current_function and current_function ~= '' then
    table.insert(status, '(' .. current_function .. ')')
  end

  for _, client in ipairs(vim.lsp.buf_get_clients()) do
    table.insert(status, client.name)
  end

  return table.concat(status, ' ')
end

return M
