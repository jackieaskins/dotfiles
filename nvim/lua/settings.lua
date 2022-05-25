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
  { 'FileType', { command = 'setlocal formatoptions-=r formatoptions-=o' } },
})

-- General
opt.hidden = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 5
opt.showmode = false
opt.signcolumn = 'yes'
opt.splitright = true
opt.splitbelow = true
opt.diffopt:append({ 'vertical' })
opt.termguicolors = true
opt.tabline = require('tabline')

function WinBar()
  if vim.bo.filetype == 'NvimTree' then
    return '%#NvimTreeNormal#'
  end
  return '%=%f'
end
opt.winbar = '%!luaeval("WinBar()")'

augroup('spell', {
  { 'FileType', { pattern = 'gitcommit,markdown', command = 'setlocal spell' } },
})

augroup('colorcolumn', {
  { 'FileType', { pattern = 'lua', command = 'setlocal colorcolumn=120' } },
})

augroup('lastplace', {
  {
    'BufReadPost',
    {
      callback = function()
        local test_line_data = vim.api.nvim_buf_get_mark(0, '"')
        local test_line = test_line_data[1]
        local last_line = vim.api.nvim_buf_line_count(0)

        if test_line > 0 and test_line <= last_line then
          vim.api.nvim_win_set_cursor(0, test_line_data)
        end
      end,
    },
  },
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
