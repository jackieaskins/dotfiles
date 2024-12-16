---Generate a string for an option list
---@param ... string
---@return string
local function gen_list_option(...)
  return table.concat({ ... }, ',')
end

-- General
vim.o.hidden = true
vim.o.number = true
vim.o.signcolumn = 'no'
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.linebreak = true
vim.o.showmode = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = 'cursor'
vim.o.diffopt = gen_list_option(vim.o.diffopt, 'vertical', 'linematch:60')
vim.o.matchpairs = gen_list_option(vim.o.matchpairs, '<:>')
vim.o.undofile = true
vim.o.viewoptions = gen_list_option('cursor', 'folds')
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.ruler = false

-- Statusline, Tabline, Winbar
vim.o.laststatus = 3
vim.g.qf_disable_statusline = true
vim.o.statusline = "%{%v:lua.require('statusline').get_statusline()%}"
vim.o.tabline = "%{%v:lua.require('tabline').get_tabline()%}"
vim.o.winbar = "%{%v:lua.require('winbar').get_winbar()%}"

-- Folds
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ''
vim.o.fillchars = gen_list_option('eob: ', 'fold: ', 'foldopen:', 'foldsep: ', 'foldclose:')

-- Spaces & Tabs
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.list = true
vim.o.listchars = gen_list_option('tab:  ', 'trail:·')
vim.o.breakindent = true
vim.o.breakindentopt = gen_list_option('shift:1', 'min:0')

-- Timeouts
vim.o.ttimeoutlen = 10
vim.o.updatetime = 100

-- Searching
vim.o.inccommand = 'nosplit'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.path = gen_list_option(vim.o.path, '**')

-- Vim globals
vim.g.c_syntax_for_h = 1

-- Auto hlsearch - https://www.reddit.com/r/neovim/comments/zc720y/comment/iyvcdf0
local hlsearch_keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }
vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    local new_hlsearch = vim.tbl_contains(hlsearch_keys, vim.fn.keytrans(char))

    ---@diagnostic disable-next-line: undefined-field
    if vim.o.hlsearch ~= new_hlsearch then
      vim.o.hlsearch = new_hlsearch
    end
  end
end, vim.api.nvim_create_namespace('auto_hlsearch'))
