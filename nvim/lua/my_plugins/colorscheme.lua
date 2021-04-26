local colors = require'my_colors'
local utils = require'my_utils'
local get_highlight_string,augroup = utils.get_highlight_string,utils.augroup

local function highlight_autocmd(name, highlight)
  return {
    'ColorScheme',
    '*',
    get_highlight_string(name, highlight)
  }
end

local color_column_bg = {guibg = colors.colorcolumn_gray}
augroup('custom_colors', {
  highlight_autocmd('CursorLine', color_column_bg),
  highlight_autocmd('CursorLineNr', color_column_bg),
  highlight_autocmd('NormalFloat', color_column_bg),
  highlight_autocmd('TSComment', {guifg = colors.comment_gray, gui = 'italic'})
})

vim.o.background = 'dark'
vim.g.colors_name = 'onedark_nvim'
