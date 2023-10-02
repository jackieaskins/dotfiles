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
  },
}
