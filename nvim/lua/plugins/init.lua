local fn = vim.fn
local cmd = vim.cmd
local map = require'utils'.map

local install_path = fn.stdpath('data') .. '/site/pack/paqs/opt/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/savq/paq-nvim.git ' .. install_path)
end

cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq {'savq/paq-nvim', opt = true}

-- Appearance
paq {'tyrannicaltoucan/vim-quantum'}
require'plugins/colorscheme'

-- Brackets
paq {'AndrewRadev/splitjoin.vim'}
require'plugins/splitjoin'
paq {'tpope/vim-surround'}

-- File Navigation
paq {'junegunn/fzf', run = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
require'plugins/fzf'

-- LSP
paq {'neovim/nvim-lspconfig'}

-- General Editing
paq {'tpope/vim-abolish'}
paq {'tpope/vim-commentary'}
paq {'tpope/vim-repeat'}
paq {'hrsh7th/vim-vsnip'}
paq {'hrsh7th/nvim-compe'}
require'plugins/compe'

-- Movement
paq {'easymotion/vim-easymotion'}
paq {'szw/vim-maximizer'}
require'plugins/maximizer'
paq {'matze/vim-move'}
paq {'unblevable/quick-scope'}

-- Syntax
paq {'nvim-treesitter/nvim-treesitter', run = function() return cmd 'TSUpdate' end}
require'plugins/treesitter'

-- Testing
paq {'vim-test/vim-test'}
require'plugins/test'

map('n', '<leader>gh', "yi':!open https://github.com/<C-R>0<CR><CR>")
vim.api.nvim_exec([[
  command! PI PaqInstall
  command! PU PaqUpdate
  command! PC PaqClean
]], true)
