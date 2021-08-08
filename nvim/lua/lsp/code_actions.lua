return function()
  local method = 'textDocument/codeAction'
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }

  local all_code_actions, err = vim.lsp.buf_request_sync(0, method, params, 1000)

  if err then
    vim.cmd('echoerr "' .. err .. '"')
  end

  local code_actions = {}
  for _, response in ipairs(all_code_actions) do
    for _, result in ipairs(response.result) do
      table.insert(code_actions, result)
    end
  end

  vim.lsp.handlers[method](err, method, code_actions)
end
