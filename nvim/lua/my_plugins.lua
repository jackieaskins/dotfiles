local fn = vim.fn
local g = vim.g
local cmd = vim.cmd

vim.api.nvim_exec([[
  command! PI PackerInstall
  command! PC PackerCompile
  command! PS PackerSync
  command! PU PackerUpdate
]], true)

cmd 'packadd packer.nvim'

local function get_my_plugin_path(plugin_name)
  return g.is_personal_machine and '~/vim-plugins/' .. plugin_name or 'jackieaskins/' .. plugin_name
end

return require'packer'.startup {
  function(use)
    use {'wbthomason/packer.nvim', opt = true}
    use {'nvim-lua/plenary.nvim'}

    -- Appearance {{{
    use {'tyrannicaltoucan/vim-quantum'}
    use {'kyazdani42/nvim-web-devicons'}
    use {'mhinz/vim-startify', config = "require'my_plugins/startify'"}
    use {'norcalli/nvim-colorizer.lua', config = "require'colorizer'.setup()"}
    -- }}}

    -- Brackets {{{
    use {get_my_plugin_path('vim-closer')}
    use {'AndrewRadev/splitjoin.vim', config = "require'my_plugins/splitjoin'"}
    use {'tpope/vim-surround'}
    use {'airblade/vim-matchquote'}
    -- }}}

    -- Git {{{
    use {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = "require'gitsigns'.setup()",
    }
    use {'tpope/vim-fugitive'}
    -- }}}

    -- File Navigation {{{
    use {
      'junegunn/fzf.vim',
      requires = {'junegunn/fzf', run = fn['fzf#install']},
      config = "require'my_plugins/fzf'",
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
      config = "require'my_plugins/telescope'",
    }
    use {
      'camspiers/snap',
      requires = {'junegunn/fzf', run = fn['fzf#install']},
      config = "require'my_plugins/snap'",
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = "require'my_plugins/tree'",
    }
    -- }}}

    -- LSP {{{
    use {
      'neovim/nvim-lspconfig',
      config = "require'my_lsp'",
      requires = {
        'ray-x/lsp_signature.nvim',
        'kosayoda/nvim-lightbulb',
        {'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim'},
        'jose-elias-alvarez/nvim-lsp-ts-utils',
      },
    }
    use {
      'ojroques/nvim-lspfuzzy',
      requires = 'fzf.vim',
      config = function() if vim.g.fuzzy_finder == 'fzf' then require'lspfuzzy'.setup {} end end,
    }
    -- }}}

    -- General Editing {{{
    use {'folke/lua-dev.nvim'}
    use {'mattn/emmet-vim'}
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
      requires = {
        'nvim-treesitter/playground',
        get_my_plugin_path('nvim-ts-autotag'),
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-refactor',
      },
    }
    -- }}}

    -- Testing {{{
    use {'vim-test/vim-test', config = "require'my_plugins/test'"}
    -- }}}
  end,
  config = {display = {prompt_border = 'single'}},
}
