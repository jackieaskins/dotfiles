local utils = require('my_utils')
local opt, augroup, map = utils.opt, utils.augroup, utils.map
local cmd = vim.cmd

-- Map Leader to Space
vim.g.mapleader = ' '
map('n', '<space>', '<nop>')

-- Disable auto-comments
cmd 'filetype plugin on'
augroup('no_auto_comment', {{'FileType', '*', 'setlocal formatoptions-=r formatoptions-=o'}})

-- General
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'cursorline', true)
opt('w', 'signcolumn', 'yes')
opt('o', 'confirm', true)
opt('o', 'splitright', true)
opt('o', 'splitbelow', true)
opt('o', 'diffopt', vim.o.diffopt .. ',vertical')
opt('o', 'termguicolors', true)
opt('o', 'tabline', require 'my_tabline')

-- Status Line
augroup('statusline', {
  {'BufEnter,WinEnter', '*', [[lua require'my_statusline'.get_active()]]},
  {'BufLeave,WinLeave', '*', [[lua require'my_statusline'.get_inactive()]]},
})

-- Folds
augroup('folds', {{'FileType', 'lua,sh,vim', 'setlocal foldmethod=marker'}})
opt('w', 'foldmethod', 'expr')
opt('w', 'foldexpr', 'nvim_treesitter#foldexpr()')
opt('w', 'foldlevel', 99)

-- Terminal
cmd 'command! -nargs=* T botright split | terminal <args>'
cmd 'command! -nargs=* VT botright vsplit | terminal <args>'

-- Spaces & Tabs
opt('b', 'shiftwidth', 2)
opt('b', 'tabstop', 2)
opt('b', 'softtabstop', 2)
opt('b', 'expandtab', true)
opt('w', 'list', true)
opt('w', 'listchars', 'tab:  ,trail:·')

-- Timeouts
opt('o', 'ttimeoutlen', 10)
opt('o', 'updatetime', 100)

-- Searching
opt('o', 'inccommand', 'nosplit')
opt('o', 'hlsearch', false)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'path', vim.o.path .. ',**')
