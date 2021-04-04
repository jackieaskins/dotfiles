local fn = vim.fn
local cmd = vim.cmd
local map = require'utils'.map

map('n', '<leader>gh', "yi':!open https://github.com/<C-R>0<CR><CR>")

cmd 'packadd packer.nvim'
return require('packer').startup(function(use)
  use {'wbthomason/packer.nvim', opt = true}

  -- Appearance
  use {'tyrannicaltoucan/vim-quantum', config = [[require'plugins/colorscheme']]}
  use  {'mhinz/vim-startify', config = [[require'plugins/startify']]}

  -- Brackets
  use {'AndrewRadev/splitjoin.vim', config = [[require'plugins/splitjoin']]}
  use 'tpope/vim-surround'

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = [[require'plugins/gitsigns']],
    requires = 'nvim-lua/plenary.nvim'
  }

  -- File Navigation
  use {
    'junegunn/fzf.vim',
    config = [[require'plugins/fzf']],
    requires = {'junegunn/fzf', run = fn['fzf#install']}
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = [[require'lsp']]
  }

  -- General Editing
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use {
    'hrsh7th/nvim-compe',
    config = [[require'plugins/compe']],
    requires = 'hrsh7th/vim-vsnip'
  }

  -- Movement
  use 'easymotion/vim-easymotion'
  use {'szw/vim-maximizer', config = [[require'plugins/maximizer']]}
  use 'matze/vim-move'
  use 'unblevable/quick-scope'

  -- Syntax
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require'plugins/treesitter']]
  }

  -- Testing
  use {'vim-test/vim-test', config = [[require'plugins/test']]}
end)
