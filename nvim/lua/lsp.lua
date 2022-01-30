local icons = require('lsp.icons')

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  float = {
    source = 'always',
    border = 'rounded',
  },
  severity_sort = true,
})

for level, icon in pairs(icons) do
  local sign = 'DiagnosticSign' .. level
  vim.fn.sign_define(sign, { text = icon, texthl = sign })
end
