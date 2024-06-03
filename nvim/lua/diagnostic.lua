local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = true, border = vim.g.border_style },
  jump = { float = true },
  signs = {
    priority = require('sign_priorities').diagnostics,
    text = { '', '', '', '' },
  },
  severity_sort = true,
  update_in_insert = false,
  virtual_text = {
    prefix = function(diagnostic)
      return icons[diagnostic.severity]
    end,
    spacing = 0,
    source = 'if_many',
  },
})
