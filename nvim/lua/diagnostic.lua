local sign_hls = require('diagnostic.sign_hls')

vim.diagnostic.config({
  float = { source = 'always', border = vim.g.border_style },
  signs = {
    priority = require('sign_priorities').diagnostics,
  },
  severity_sort = true,
  update_in_insert = true,
  virtual_text = false,
})

for _, sign in ipairs(sign_hls) do
  vim.fn.sign_define(sign, { text = '', texthl = sign, numhl = sign })
end
