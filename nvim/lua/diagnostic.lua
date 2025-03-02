local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = true, border = MY_CONFIG.border_style },
  signs = {
    text = { icons[1], icons[2], icons[3], icons[4] },
    priority = require('sign_priorities').diagnostics,
  },
  severity_sort = true,
  update_in_insert = false,
  jump = { float = true },
  virtual_text = {
    current_line = false,
    source = 'if_many',
    spacing = 1,
  },
})
