local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = true, border = vim.g.border_style },
  signs = {
    priority = require('sign_priorities').diagnostics,
    text = icons,
  },
  severity_sort = true,
  update_in_insert = false,
  virtual_text = {
    prefix = function(diagnostic)
      return icons[diagnostic.severity]
    end,
    spacing = 0,
  },
})
