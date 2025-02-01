local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = true, border = MY_CONFIG.border_style },
  signs = {
    text = { icons[1], icons[2], icons[3], icons[4] },
    priority = require('sign_priorities').diagnostics,
  },
  severity_sort = true,
  update_in_insert = false,
  jump = { float = false },
  virtual_lines = { current_line = true },
  virtual_text = false,
})
