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
  highlight_autocmd('LspDiagnosticsDefaultInformation', {guifg = colors.blue}),
  highlight_autocmd('LspDiagnosticsDefaultWarning', {guifg = colors.orange}),
  highlight_autocmd('LspDiagnosticsDefaultError', {guifg = colors.red}),
})

g.quantum_black = 1
g.quantum_italics = 1
cmd 'silent! colorscheme quantum'
