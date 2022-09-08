local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = 'always', border = 'rounded' },
  signs = {
    priority = require('sign_priorities').diagnostics,
  },
  severity_sort = true,
  update_in_insert = true,
  virtual_text = false,
})

for level, _ in pairs(icons) do
  local sign = 'DiagnosticSign' .. level
  vim.fn.sign_define(sign, { texthl = sign, numhl = sign })
end
