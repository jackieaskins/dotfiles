---@type LazySpec
return {
  'levouh/tint.nvim',
  init = function() end,
  config = function()
    local tint = require('tint')

    tint.setup({
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
        'GitSignsStaged*',
        '^LineNr',
        'Whitespace',
        'WinbarNC',
        'WinSeparator',
      },
    })

    require('utils').augroup('tint', {
      { 'ColorScheme', callback = tint.refresh },
    })
  end,
}
