local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = true },
  signs = {
    text = icons,
    priority = require('sign_priorities').diagnostics,
  },
  severity_sort = true,
  update_in_insert = false,
  jump = { float = false },
  virtual_lines = false,
  virtual_text = false,
})
