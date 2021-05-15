local fn = vim.fn
local cmd = vim.cmd

vim.api.nvim_exec([[
  command! PC lua require('user').clean()
  command! PU lua require('user').update()
]], true)

local user_install_path = vim.fn.stdpath('data') ..
                              '/site/pack/user/opt/jackieaskins/user.nvim/default/default'
if vim.fn.empty(vim.fn.glob(user_install_path)) > 0 then
  os.execute('git clone --depth 1 https://github.com/jackieaskins/user.nvim.git "' ..
                 user_install_path .. '"')
end
cmd 'packadd jackieaskins/user.nvim/default/default'

local user = require("user")
user.setup()
local use = user.use

use {'jackieaskins/user.nvim'}
use {'nvim-lua/plenary.nvim'}

-- Appearance {{{
use {'tyrannicaltoucan/vim-quantum', config = function() require 'my_plugins/colorscheme' end}
use {'kyazdani42/nvim-web-devicons'}
use {'mhinz/vim-startify', config = function() require 'my_plugins/startify' end}
use {'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end}
-- }}}

-- Brackets {{{
use {'jackieaskins/vim-closer'}
use {'AndrewRadev/splitjoin.vim', config = function() require 'my_plugins/splitjoin' end}
use {'tpope/vim-surround'}
use {'airblade/vim-matchquote'}
-- }}}

-- Git {{{
use {
  'lewis6991/gitsigns.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function() require'gitsigns'.setup() end,
}
use {'tpope/vim-fugitive'}
-- }}}

-- File Navigation {{{
local function install_fzf() fn['fzf#install']() end
use {
  'junegunn/fzf.vim',
  requires = {'junegunn/fzf', install = install_fzf, update = install_fzf},
  config = function() require 'my_plugins/fzf' end,
}
use {
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function() require 'my_plugins/tree' end,
}
-- }}}

-- LSP {{{
use {
  'neovim/nvim-lspconfig',
  config = function() require 'my_lsp' end,
  requires = {
    'ray-x/lsp_signature.nvim',
    'kosayoda/nvim-lightbulb',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    'RRethy/vim-illuminate',
  },
}
use {
  'ojroques/nvim-lspfuzzy',
  requires = 'junegunn/fzf.vim',
  config = function() require'lspfuzzy'.setup {} end,
}
-- }}}

-- General Editing {{{
use {'mattn/emmet-vim'}
use {'tpope/vim-abolish'}
use {'tpope/vim-commentary'}
use {'tpope/vim-repeat'}
use {
  'hrsh7th/nvim-compe',
  requires = 'hrsh7th/vim-vsnip',
  config = function() require 'my_plugins/compe' end,
}
use {'axelf4/vim-strip-trailing-whitespace'}
use {'mhartington/formatter.nvim', config = function() require 'my_plugins/formatter' end}
-- }}}

-- Movement {{{
use {'phaazon/hop.nvim', config = function() require 'my_plugins/hop' end}
use {'szw/vim-maximizer', config = function() require 'my_plugins/maximizer' end}
use {'matze/vim-move'}
use {'unblevable/quick-scope'}
-- }}}

-- Syntax {{{
use {
  'nvim-treesitter/nvim-treesitter',
  update = function() cmd 'TSUpdate' end,
  config = function() require 'my_plugins/treesitter' end,
}
use {'jackieaskins/nvim-ts-autotag', after = 'nvim-treesitter/nvim-treesitter'}
use {'nvim-treesitter/playground', after = 'nvim-treesitter/nvim-treesitter'}
use {'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter/nvim-treesitter'}
-- }}}

-- Testing {{{
use {'vim-test/vim-test', config = function() require 'my_plugins/test' end}
-- }}}

user.startup()
