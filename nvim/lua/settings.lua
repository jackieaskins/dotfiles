local map = require('utils').map

-- Configuration Variables
---@type boolean
vim.g.is_personal_machine = false

---@class AdditionalServer
---@field lspconfig lspconfig.Config
---@field server LspServer

---@type table<string, AdditionalServer>
vim.g.additional_servers = {}
---@type string[]
vim.g.supported_servers = {}

---@type string[]
vim.g.supported_debuggers = {}
---@type string[]
vim.g.supported_formatters = {}
---@type string[]
vim.g.supported_linters = {}

---@type GxMatcher[]
vim.g.custom_matchers = {}

---@type string[]
vim.g.border_style = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' }

-- Map Leader to Space
vim.g.mapleader = ' '
map({ 'n', 'v' }, '<space>', '<nop>')

-- General
vim.opt.hidden = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:1,min:0'
vim.opt.showmode = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.diffopt:append({ 'vertical', 'linematch:60' })
vim.opt.matchpairs:append({ '<:>' })
vim.opt.jumpoptions = 'stack'
vim.opt.undofile = true

-- Statusline, Tabline, Winbar
vim.opt.laststatus = 3
vim.g.qf_disable_statusline = true
vim.opt.statusline = "%{%v:lua.require('statusline').get_statusline()%}"
vim.opt.tabline = "%{%v:lua.require('tabline').get_tabline()%}"
vim.opt.winbar = "%{%v:lua.require('winbar').get_winbar()%}"

-- Folds
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

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

-- Auto hlsearch - https://www.reddit.com/r/neovim/comments/zc720y/comment/iyvcdf0
local hlsearch_keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }
vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    local new_hlsearch = vim.tbl_contains(hlsearch_keys, vim.fn.keytrans(char))

    ---@diagnostic disable-next-line: undefined-field
    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end, vim.api.nvim_create_namespace('auto_hlsearch'))
