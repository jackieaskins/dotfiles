return {
  'levouh/tint.nvim',
  opts = function()
    return {
      tint = vim.o.background == 'dark' and -45 or 60,
      saturation = 0.6,
      highlight_ignore_patterns = {
        '@comment',
        '@ibl.indent.char.1',
        'Comment',
        'DapUIUnavailable',
        'EndOfBuffer',
        'FoldColumn',
        '^LineNr',
        'Whitespace',
        'WinbarNC',
        'WinSeparator',
      },
    }
  end,
}
