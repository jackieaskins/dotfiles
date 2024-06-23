local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = true, border = vim.g.border_style },
  signs = false,
  severity_sort = true,
  update_in_insert = false,
  jump = { float = true },
  virtual_text = {
    prefix = function(diagnostic)
      return ' ' .. icons[diagnostic.severity]
    end,
    format = function()
      return ''
    end,
    spacing = 0,
    virt_text_pos = 'right_align',
    virt_text_hide = true,
  },
})
