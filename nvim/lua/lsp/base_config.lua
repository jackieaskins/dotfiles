return function()
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  return {
    capabilities = capabilities,
    on_attach = require('lsp.attach'),
    flags = { debounce_text_changes = 150 },
  }
end
