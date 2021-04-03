-- TODO: Folds, Reload Neovim (may require plenary), Java autocmd for spacing & comments, showtabline?, showmatch?, open url under cursor

local utils = require('utils')
local opt = utils.opt
local cmd = vim.cmd

-- Map Leader to Space
vim.g.mapleader = ' '

-- General
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'cursorline', true)
opt('w', 'signcolumn', 'yes')
opt('o', 'confirm', true)
opt('o', 'splitright', true)
opt('o', 'splitbelow', true)

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
opt('o', 'diffopt', vim.o.diffopt .. ',vertical')

-- Searching
opt('o', 'inccommand', 'nosplit')
opt('o', 'hlsearch', false)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'path', vim.o.path .. '**')
