local tint = require('tint')

tint.setup({
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

require('utils').augroup('tint_colorscheme', {
  { 'ColorScheme', {
    callback = function()
      tint.refresh()
    end,
  } },
})
