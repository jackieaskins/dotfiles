local utils = require('utils')
local augroup, map = utils.augroup, utils.map
local cmd, g, opt = vim.cmd, vim.g, vim.opt

-- Flags
g.is_personal_machine = false

-- Map Leader to Space
g.mapleader = ' '
map('n', '<space>', '<nop>')

-- Disable auto-comments
cmd('filetype plugin on')
augroup('no_auto_comment', { { 'FileType', '*', 'setlocal formatoptions-=r formatoptions-=o' } })

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
  { 'BufRead,BufNewFile', '*.md', 'setlocal spell' },
})

augroup('filetypes', {
  { 'BufRead,BufNewFile', '*.graphql', 'set filetype=graphql' },
  { 'BufRead,BufNewFile', 'Brewfile*', 'set filetype=ruby' },
  { 'BufRead,BufNewFile', 'tmux/*.conf', 'set filetype=tmux' },
  { 'BufRead,BufNewFile', 'tmux.conf', 'set filetype=tmux' },
})

augroup('colorcolumn', {
  { 'BufRead,BufNewFile', '*.lua', 'set colorcolumn=120' },
})

-- Folds
augroup('folds', { { 'FileType', 'lua,sh,vim', 'setlocal foldmethod=marker' } })
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99

-- Terminal
cmd('command! -nargs=* T botright split | terminal <args>')
cmd('command! -nargs=* VT botright vsplit | terminal <args>')

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
