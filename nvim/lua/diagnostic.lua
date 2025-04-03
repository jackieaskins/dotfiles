local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = true },
  signs = {
    text = { icons[1], icons[2], icons[3], icons[4] },
    priority = require('sign_priorities').diagnostics,
  },
  severity_sort = true,
  update_in_insert = false,
  jump = { float = true },
  -- Inspired by https://www.reddit.com/r/neovim/comments/1jpbc7s/disable_virtual_text_if_there_is_diagnostic_in/
  virtual_lines = { current_line = true },
  virtual_text = {
    current_line = false,
    source = 'if_many',
    spacing = 1,
    format = function(diagnostic)
      if diagnostic.lnum == vim.fn.line('.') - 1 then
        return nil
      end

      return diagnostic.message
    end,
  },
})

require('utils').augroup('diagnostic_cursor_hold', {
  {
    'CursorHold',
    callback = function()
      vim.diagnostic.show(nil, 0)
    end,
  },
})
