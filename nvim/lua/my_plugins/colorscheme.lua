local colors = require 'my_colors'
local utils = require 'my_utils'
local get_highlight_string, augroup = utils.get_highlight_string, utils.augroup

local function highlight_autocmd(name, highlight)
  return {'ColorScheme', '*', get_highlight_string(name, highlight)}
end

local function clear_highlight_autocmd(name) return {'ColorScheme', '*', 'highlight clear ' .. name} end

local color_column_bg = {guibg = colors.colorcolumn_gray}
augroup('custom_colors', {
  highlight_autocmd('CursorLine', color_column_bg),
  highlight_autocmd('CursorLineNr', color_column_bg),
  highlight_autocmd('NormalFloat', color_column_bg),
  highlight_autocmd('TSComment', {guifg = colors.comment_gray, gui = 'italic'}),
  highlight_autocmd('ModeMsg', {guifg = colors.comment_gray}),
  highlight_autocmd('QuickScopePrimary', {guifg = '#ff007c'}),
  highlight_autocmd('QuickScopeSecondary', {guifg = '#00dfff'}),
  clear_highlight_autocmd('StartifyFile'),
  clear_highlight_autocmd('StartifyPath'),
  clear_highlight_autocmd('StartifySlash'),
  clear_highlight_autocmd('StartifySection'),
  clear_highlight_autocmd('StartifySpecial'),
  clear_highlight_autocmd('TSNone'),
})

vim.o.background = 'dark'
vim.g.colors_name = 'onedark_nvim'
