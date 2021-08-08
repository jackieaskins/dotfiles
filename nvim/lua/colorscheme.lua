local cmd = vim.cmd
local colors = require('colors')
local utils = require('utils')
local get_highlight_string, augroup = utils.get_highlight_string, utils.augroup

local function highlight_autocmd(name, highlight)
  return { 'ColorScheme', '*', get_highlight_string(name, highlight) }
end

augroup('custom_colors', {
  highlight_autocmd('QuickScopePrimary', { guifg = '#ff007c' }),
  highlight_autocmd('QuickScopeSecondary', { guifg = '#00dfff' }),

  highlight_autocmd('LspDiagnosticsDefaultInformation', { guifg = colors.cyan }),
  highlight_autocmd('LspDiagnosticsVirtualTextInformation', { guifg = colors.cyan }),
  highlight_autocmd('LspDiagnosticsUnderlineInformation', { guifg = colors.cyan, gui = 'underline' }),
  highlight_autocmd('LspDiagnosticsFloatingInformation', { guifg = colors.cyan, guibg = colors.gray2 }),
  highlight_autocmd('LspDiagnosticsSignInformation', { guifg = colors.cyan }),

  highlight_autocmd('LspDiagnosticsDefaultHint', { guifg = colors.blue }),
  highlight_autocmd('LspDiagnosticsVirtualTextHint', { guifg = colors.blue }),
  highlight_autocmd('LspDiagnosticsUnderlineHint', { guifg = colors.blue, gui = 'underline' }),
  highlight_autocmd('LspDiagnosticsFloatingHint', { guifg = colors.blue, guibg = colors.gray2 }),
  highlight_autocmd('LspDiagnosticsSignHint', { guifg = colors.blue }),

  highlight_autocmd('MatchParen', { guifg = colors.cyan }),
})

cmd('silent! colorscheme one-nvim')
