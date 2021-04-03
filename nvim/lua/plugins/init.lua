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

paq {'tyrannicaltoucan/vim-quantum'}
require'plugins/colorscheme'

paq {'junegunn/fzf', run = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
require'plugins/fzf'

paq {'neovim/nvim-lspconfig'}
paq {'hrsh7th/nvim-compe'}
require'plugins/compe'

paq {'nvim-treesitter/nvim-treesitter', run = function() return cmd 'TSUpdate' end}
require'plugins/treesitter'

map('n', '<leader>gh', "yi':!open https://github.com/<C-R>0<CR><CR>")
vim.api.nvim_exec([[
  command! PI PaqInstall
  command! PU PaqUpdate
  command! PC PaqClean
]], true)
