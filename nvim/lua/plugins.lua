local fn = vim.fn
local cmd = vim.cmd
local map = require'utils'.map

vim.api.nvim_exec([[
  command! PI PackerInstall
  command! PC PackerCompile
  command! PS PackerSync
]], true)
map('n', '<leader>gh', "yi':!open https://github.com/<C-R>0<CR><CR>")

cmd 'packadd packer.nvim'
return require('packer').startup(function(use)
  use {'wbthomason/packer.nvim', opt = true}

  -- Appearance {{{
  use {'tyrannicaltoucan/vim-quantum', after = 'quick-scope', config = [[require'plugins/colorscheme']]}
  use {'glepnir/galaxyline.nvim', config = [[require'plugins/galaxyline']], disable = true}
  use 'kyazdani42/nvim-web-devicons'
  use {'lambdalisue/glyph-palette.vim', config = [[require'plugins/glyph-palette']]}
  use {'mhinz/vim-startify', config = [[require'plugins/startify']]}
  use {'norcalli/nvim-colorizer.lua', config = [[require'colorizer'.setup()]]}
  -- }}}

  -- Brackets {{{
  use {'AndrewRadev/splitjoin.vim', config = [[require'plugins/splitjoin']]}
  use 'tpope/vim-surround'
  -- }}}

  -- Git {{{
  use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim', config = [[require'plugins/gitsigns']]}
  use 'tpope/vim-fugitive'
  -- }}}

  -- File Navigation {{{
  use {'junegunn/fzf.vim', requires = {'junegunn/fzf', run = fn['fzf#install']}, config = [[require'plugins/fzf']]}
  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', config = [[require'plugins/tree']]}
  -- }}}

  -- LSP {{{
  use {'neovim/nvim-lspconfig', after = {'vim-quantum', 'lsp_signature.nvim'}, config = [[require'lsp']]}
  use {'kosayoda/nvim-lightbulb', config = [[require'plugins/lightbulb']]}
  use {'ojroques/nvim-lspfuzzy', requires = 'fzf.vim', config = [[require'lspfuzzy'.setup{}]]}
  use 'ray-x/lsp_signature.nvim'
  -- }}}

  -- General Editing {{{
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use {'hrsh7th/nvim-compe', requires = 'hrsh7th/vim-vsnip', config = [[require'plugins/compe']]}
  use 'axelf4/vim-strip-trailing-whitespace'
  use {'mhartington/formatter.nvim', config = [[require'plugins/formatter']]}
  -- }}}

  -- Movement {{{
  use {'phaazon/hop.nvim', config = [[require'plugins/hop']]}
  use {'szw/vim-maximizer', config = [[require'plugins/maximizer']]}
  use 'matze/vim-move'
  use {'unblevable/quick-scope', config = [[require'plugins/quick-scope']]}
  -- }}}

  -- Syntax {{{
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = [[require'plugins/treesitter']]}
  -- }}}

  -- Testing {{{
  use {'vim-test/vim-test', config = [[require'plugins/test']]}
  -- }}}
end)
