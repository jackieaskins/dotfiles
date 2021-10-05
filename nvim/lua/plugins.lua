vim.cmd('packadd packer.nvim')

return require('packer').startup({
  function(use)
    use({ 'wbthomason/packer.nvim', opt = true })

    -- Dev Tools {{{
    use({ 'lewis6991/impatient.nvim' })
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
    use({
      'norcalli/nvim-colorizer.lua',
      cmd = 'ColorizerToggle',
      config = function()
        require('colorizer').setup()
      end,
    })
    -- }}}

    -- Editing {{{
    use({ 'tpope/vim-abolish' })
    use({ 'tpope/vim-commentary' })
    use({ 'tpope/vim-repeat' })
    use({ 'tpope/vim-sleuth' })
    use({
      'mattn/emmet-vim',
      keys = { { 'i', '\\m' } },
      setup = function()
        require('plugins.emmet')
      end,
    })
    use({ 'axelf4/vim-strip-trailing-whitespace' })
    use({
      'iamcco/markdown-preview.nvim',
      ft = { 'markdown' },
      run = 'cd app && npm install',
    })
    use({
      'L3MON4D3/LuaSnip',
      config = function()
        require('plugins.LuaSnip')
      end,
    })
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-calc' },
        { 'hrsh7th/cmp-nvim-lsp' },
      },
      config = function()
        require('plugins.cmp')
      end,
    })
    -- }}}

    -- Surround {{{
    use({ 'airblade/vim-matchquote' })
    use({
      'AndrewRadev/splitjoin.vim',
      config = function()
        require('plugins.splitjoin')
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
      'lambdalisue/fern.vim',
      requires = {
        { 'lambdalisue/fern-hijack.vim' },
        { 'lambdalisue/fern-git-status.vim', opt = true },
        { 'lambdalisue/nerdfont.vim', after = 'fern.vim' },
        { 'lambdalisue/fern-renderer-nerdfont.vim', after = 'fern.vim' },
      },
      cmd = { 'Fern' },
      config = function()
        require('plugins.fern')
      end,
    })
    use({
      'nvim-telescope/telescope.nvim',
      config = function()
        require('plugins.telescope')
      end,
      requires = {
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
    })
    -- }}}

    -- LSP {{{
    use({ 'folke/lua-dev.nvim' })
    use({
      'ray-x/lsp_signature.nvim',
      config = function()
        require('plugins.lsp_signature')
      end,
    })
    use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', commit = '2fd9a7d17d48fa95d889f8d7f8677d1375e52a9b' })
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
        require('plugins.lspconfig')
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
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup({ default_mappings = true })
      end,
      keys = { 'gpd', 'gpi', 'gpr', 'gP' },
    })
    -- }}}

    -- Movement {{{
    use({
      'unblevable/quick-scope',
      config = function()
        require('plugins.quick-scope')
      end,
    })
    use({ 'matze/vim-move' })
    use({
      'phaazon/hop.nvim',
      config = function()
        require('plugins.hop')
      end,
      keys = '<leader><leader>',
    })
    -- }}}

    -- Treesitter {{{
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end,
    })
    use({
      {
        'nvim-treesitter/playground',
        cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
        requires = 'nvim-treesitter/nvim-treesitter',
      },
      { 'jackieaskins/nvim-ts-autotag', requires = 'nvim-treesitter/nvim-treesitter' },
      { 'nvim-treesitter/nvim-treesitter-refactor', requires = 'nvim-treesitter/nvim-treesitter' },
      { 'RRethy/nvim-treesitter-textsubjects', requires = 'nvim-treesitter/nvim-treesitter' },
      { 'JoosepAlviste/nvim-ts-context-commentstring', requires = 'nvim-treesitter/nvim-treesitter' },
    })
    -- }}}

    -- Testing {{{
    use({
      'vim-test/vim-test',
      cmd = {
        'TestNearest',
        'TestFile',
        'TestSuite',
        'TestLast',
        'TestVisit',
      },
      config = function()
        require('plugins.test')
      end,
    })
    -- }}}
  end,
  config = {
    display = { prompt_border = 'single' },
    profile = { enable = true },
  },
})
