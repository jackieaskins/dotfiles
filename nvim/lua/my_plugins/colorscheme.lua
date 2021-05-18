local cmd, g = vim.cmd, vim.g
local colors = require 'my_colors'
local utils = require 'my_utils'
local get_highlight_string, augroup = utils.get_highlight_string, utils.augroup

local function highlight_autocmd(name, highlight)
  return {'ColorScheme', '*', get_highlight_string(name, highlight)}
end

augroup('custom_colors', {
  highlight_autocmd('QuickScopePrimary', {guifg = '#ff007c'}),
  highlight_autocmd('QuickScopeSecondary', {guifg = '#00dfff'}),
  highlight_autocmd('LspDiagnosticsDefaultHint', {guifg = colors.cyan}),
  highlight_autocmd('LspDiagnosticsUnderlineHint', {guifg = colors.cyan, gui = 'underline'}),
  highlight_autocmd('LspDiagnosticsDefaultInformation', {guifg = colors.blue}),
  highlight_autocmd('LspDiagnosticsUnderlineInformation', {guifg = colors.blue, gui = 'underline'}),
  highlight_autocmd('LspDiagnosticsDefaultWarning', {guifg = colors.orange}),
  highlight_autocmd('LspDiagnosticsUnderlineWarning', {guifg = colors.orange, gui = 'underline'}),
  highlight_autocmd('LspDiagnosticsDefaultError', {guifg = colors.red}),
  highlight_autocmd('LspDiagnosticsUnderlineError', {guifg = colors.red, gui = 'underline'}),
  highlight_autocmd('LspReferenceText', {guibg = colors.gray3}),
  highlight_autocmd('LspReferenceRead', {guibg = colors.gray3}),
  highlight_autocmd('LspReferenceWrite', {guibg = colors.gray3}),
  highlight_autocmd('NormalFloat', {guibg = colors.gray2}),
  highlight_autocmd('GitSignsAdd', {guifg = colors.green}),
  highlight_autocmd('GitSignsChange', {guifg = colors.yellow}),
  highlight_autocmd('GitSignsDelete', {guifg = colors.red}),
})

g.quantum_black = 1
g.quantum_italics = 1
cmd 'silent! colorscheme quantum'
