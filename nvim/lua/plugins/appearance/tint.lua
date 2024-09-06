---@type LazySpec
return {
  'levouh/tint.nvim',
  ---@module 'tint'
  ---@type TintUserConfiguration
  opts = {
    tint = vim.o.background == 'dark' and -45 or 60,
    ---@diagnostic disable-next-line: assign-type-mismatch
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
  },
}
