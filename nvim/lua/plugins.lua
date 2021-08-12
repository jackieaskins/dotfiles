local cmd, fn = vim.cmd, vim.fn

cmd('packadd packer.nvim')

return require('packer').startup({
  function(use)
    use({ 'wbthomason/packer.nvim', opt = true })

    -- Dev Tools {{{
    use({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
    use({
      'famiu/nvim-reload',
      cmd = { 'Restart', 'Reload' },
      requires = 'nvim-lua/plenary.nvim',
    })
    use({
      'stsewd/gx-extended.vim',
      keys = 'gx',
    })
    -- }}}

    -- Appearance {{{
    use({ 'sainnhe/edge' })
    use({ 'kyazdani42/nvim-web-devicons' })
    use({ 'norcalli/nvim-colorizer.lua', cmd = 'ColorizerToggle' })
    -- }}}

    -- Editing {{{
    use({ 'tpope/vim-abolish' })
    use({ 'tpope/vim-commentary' })
    use({ 'tpope/vim-repeat' })
    use({ 'axelf4/vim-strip-trailing-whitespace' })
    use({
      'hrsh7th/nvim-compe',
      requires = 'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      config = function()
        require('plugins/compe')
      end,
    })
    -- }}}

    -- Brackets {{{
    use({ 'airblade/vim-matchquote' })
    use({
      'AndrewRadev/splitjoin.vim',
      config = function()
        require('plugins/splitjoin')
      end,
      keys = { 'gJ', 'gS' },
    })
    use({ 'tpope/vim-surround' })
    -- }}}

    -- Git {{{
    use({
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('gitsigns').setup()
      end,
    })
    use({ 'tpope/vim-fugitive', cmd = { 'Git', 'G', 'Gread' } })
    -- }}}

    -- File Navigation {{{
    use({
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
      config = function()
        require('plugins/tree')
      end,
    })
    use({
      'junegunn/fzf.vim',
      requires = { 'junegunn/fzf', run = fn['fzf#install'] },
      config = function()
        require('plugins/fzf')
      end,
    })
    -- }}}

    -- LSP {{{
    use({ 'folke/lua-dev.nvim' })
    use({ 'ray-x/lsp_signature.nvim' })
    use({ 'jose-elias-alvarez/nvim-lsp-ts-utils' })
    use({
      'kosayoda/nvim-lightbulb',
      config = function()
        -- Explicitly assigning to avoid default highlight
        vim.fn.sign_define('LightBulbSign', { text = '💡' })
      end,
    })
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins/lspconfig')
      end,
    })
    use({
      'jose-elias-alvarez/null-ls.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
      },
    })
    use({
      'ojroques/nvim-lspfuzzy',
      requires = {
        { 'junegunn/fzf' },
        { 'junegunn/fzf.vim' },
      },
      config = function()
        require('lspfuzzy').setup({})
      end,
    })
    use({
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup({ default_mappings = true })
      end,
      keys = { 'gpd', 'gpi', 'gP' },
    })
    -- }}}

    -- Movement {{{
    use({ 'unblevable/quick-scope' })
    use({ 'matze/vim-move' })
    use({
      'phaazon/hop.nvim',
      config = function()
        require('plugins/hop')
      end,
      keys = '<leader><leader>',
    })
    -- }}}

    -- Treesitter {{{
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('plugins/treesitter')
      end,
    })
    use({
      requires = 'nvim-treesitter/nvim-treesitter',
      {
        'nvim-treesitter/playground',
        cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
      },
      { 'jackieaskins/nvim-ts-autotag' },
      { 'nvim-treesitter/nvim-treesitter-refactor' },
      { 'RRethy/nvim-treesitter-textsubjects' },
    })
    -- }}}
  end,
  config = {
    display = { prompt_border = 'single' },
    profile = { enable = true },
  },
})
