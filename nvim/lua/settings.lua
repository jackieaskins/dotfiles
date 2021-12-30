local utils = require('utils')
local augroup, map = utils.augroup, utils.map
local opt = vim.opt

-- Flags
vim.g.is_personal_machine = false

-- Map Leader to Space
vim.g.mapleader = ' '
map('n', '<space>', '<nop>')

-- Disable auto-comments
vim.cmd('filetype plugin on')
augroup('no_auto_comment', {
  { 'FileType', '*', 'setlocal formatoptions-=r formatoptions-=o' },
})

-- General
opt.hidden = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 5
opt.signcolumn = 'yes'
opt.splitright = true
opt.splitbelow = true
opt.diffopt:append({ 'vertical' })
opt.termguicolors = true
opt.showtabline = 2
opt.tabline = require('tabline')

augroup('spell', {
  { 'FileType', 'markdown', 'setlocal spell' },
})

augroup('colorcolumn', {
  { 'FileType', 'lua', 'setlocal colorcolumn=120' },
})

-- Folds
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99

-- Spaces & Tabs
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.list = true
opt.listchars = 'tab:  ,trail:·'

-- Timeouts
opt.ttimeoutlen = 10
opt.updatetime = 100

-- Searching
opt.inccommand = 'nosplit'
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.path:append({ '**' })
