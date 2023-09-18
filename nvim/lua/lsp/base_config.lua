return function()
  local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

  if ok then
    local capabilities =
      vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

    return { capabilities = capabilities }
  else
    return { capabilities = vim.lsp.protocol.make_client_capabilities() }
  end
end
