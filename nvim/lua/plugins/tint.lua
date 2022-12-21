local M = { 'levouh/tint.nvim' }

function M.config()
  require('tint').setup({
    tint = -45,
    saturation = 0.6,
    highlight_ignore_patterns = {
      'EndOfBuffer',
      'IndentBlanklineChar',
      '^LineNr',
      'WinbarNC',
      'WinSeparator',
    },
  })
end

return M
