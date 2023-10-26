return {
  'levouh/tint.nvim',
  opts = {
    tint = -45,
    saturation = 0.6,
    highlight_ignore_patterns = {
      '@comment',
      '@ibl.indent.char.1',
      'Comment',
      'EndOfBuffer',
      '^LineNr',
      'WinbarNC',
      'WinSeparator',
    },
    window_ignore_function = function(winid)
      local bufid = vim.api.nvim_win_get_buf(winid)
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufid })
      return vim.startswith(filetype, 'Telescope')
    end,
  },
}
