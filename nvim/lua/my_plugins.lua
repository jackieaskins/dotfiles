local fn = vim.fn
local cmd = vim.cmd
local map = require'my_utils'.map

vim.api.nvim_exec([[
  command! PI PackerInstall
  command! PC PackerCompile
  command! PS PackerSync
  command! PU PackerUpdate
]], true)
map('n', '<leader>gh', "yi':!open https://github.com/<C-R>0<CR><CR>")

cmd 'packadd packer.nvim'

return require('packer').startup(function(use)
  use {'wbthomason/packer.nvim', opt = true}
  use {'nvim-lua/plenary.nvim'}

  -- Appearance {{{
  use {'olimorris/onedark.nvim', requires = 'rktjmp/lush.nvim'}
  use {'kyazdani42/nvim-web-devicons'}
  use {'mhinz/vim-startify', config = "require'my_plugins/startify'"}
  use {'norcalli/nvim-colorizer.lua', config = "require'colorizer'.setup()"}
  -- }}}

  -- Brackets {{{
  use {'jackieaskins/vim-closer'}
  use {'AndrewRadev/splitjoin.vim', config = "require'my_plugins/splitjoin'"}
  use {'tpope/vim-surround'}
  use {'airblade/vim-matchquote'}
  -- }}}

  -- Git {{{
  use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim', config = "require'gitsigns'.setup()"}
  use {'tpope/vim-fugitive'}
  -- }}}

  -- File Navigation {{{
  use {'junegunn/fzf.vim', requires = {'junegunn/fzf', run = fn['fzf#install']}, config = "require'my_plugins/fzf'"}
  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', config = "require'my_plugins/tree'"}
  -- }}}

  -- LSP {{{
  use {'neovim/nvim-lspconfig', config = "require'my_lsp'"}
  use {'ray-x/lsp_signature.nvim'}
  use {'kosayoda/nvim-lightbulb', config = "require'my_plugins/lightbulb'"}
  use {'ojroques/nvim-lspfuzzy', requires = 'fzf.vim', config = "require'lspfuzzy'.setup{}"}
  -- }}}

  -- General Editing {{{
  use {'tpope/vim-abolish'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-repeat'}
  use {'hrsh7th/nvim-compe', requires = 'hrsh7th/vim-vsnip', config = "require'my_plugins/compe'"}
  use {'axelf4/vim-strip-trailing-whitespace'}
  use {'mhartington/formatter.nvim', config = "require'my_plugins/formatter'"}
  -- }}}

  -- Movement {{{
  use {'phaazon/hop.nvim', config = "require'my_plugins/hop'"}
  use {'szw/vim-maximizer', config = "require'my_plugins/maximizer'"}
  use {'matze/vim-move'}
  use {'unblevable/quick-scope'}
  -- }}}

  -- Syntax {{{
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = "require'my_plugins/treesitter'",
    requires = {'nvim-treesitter/playground', 'jackieaskins/nvim-ts-autotag'}
  }
  -- }}}

  -- Testing {{{
  use {'vim-test/vim-test', config = "require'my_plugins/test'"}
  -- }}}
end)
