return {
  'levouh/tint.nvim',
  opts = {
    tint = -45,
    saturation = 0.6,
    highlight_ignore_patterns = {
      '@comment',
      'Comment',
      'EndOfBuffer',
      'IndentBlanklineChar',
      '^LineNr',
      'WinbarNC',
      'WinSeparator',
    },
  },
}
