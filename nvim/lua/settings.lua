local map = require('utils').map

-- Configuration Variables
vim.g.is_personal_machine = false
vim.g.additional_server_commands = {}
vim.g.supported_servers = {}
vim.g.catppuccin_flavour = 'macchiato'
vim.g.border_style = 'rounded'

-- Map Leader to Space
vim.g.mapleader = ' '
map({ 'n', 'v' }, '<space>', '<nop>')

-- General
vim.opt.hidden = true
vim.opt.mouse = ''
vim.opt.number = true
vim.opt.ruler = false
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.diffopt:append({ 'vertical', 'linematch:60' })
vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.tabline = "%{%v:lua.require('tabline').get_tabline()%}"

-- Folds
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Spaces & Tabs
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = 'tab:  ,trail:·'

-- Timeouts
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100

-- Searching
vim.opt.inccommand = 'nosplit'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.path:append({ '**' })

-- Vim globals
vim.g.c_syntax_for_h = 1
