local cmd, g = vim.cmd, vim.g
local colors = require('colors')
local utils = require('utils')
local get_highlight_string, augroup = utils.get_highlight_string, utils.augroup

local function highlight_autocmd(name, highlight)
  return { 'ColorScheme', '*', get_highlight_string(name, highlight) }
end

augroup('custom_colors', {
  highlight_autocmd('CursorLineNr', { guifg = colors.blue }),
  highlight_autocmd('NormalFloat', { guifg = colors.fg, guibg = colors.bg0 }),

  -- Used by FZF for cursor line highlight
  { 'ColorScheme', '*', 'let g:terminal_color_8 = "' .. colors.bg1 .. '"' },
})

g.edge_style = 'neon'
g.edge_diagnostic_virtual_text = 'colored'
g.edge_better_performance = 1

cmd('silent! colorscheme edge')
