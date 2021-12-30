vim.cmd('packadd packer.nvim')

return require('packer').startup({
  function(use)
    use({ 'wbthomason/packer.nvim', opt = true })

    -- Dev Tools {{{
    -- Needed until https://github.com/neovim/neovim/issues/12587 is fixed
    use({ 'antoinemadec/FixCursorHold.nvim' })
    use({ 'lewis6991/impatient.nvim' })
    use({
      'nathom/filetype.nvim',
      config = function()
        require('plugins.filetype')
      end,
    })
    use({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
    use({
      'stsewd/gx-extended.vim',
      keys = 'gx',
      fn = 'gxext#browse',
    })
    use({
      'szw/vim-maximizer',
      cmd = { 'MaximizerToggle' },
      config = function()
        require('plugins.maximizer')
      end,
    })
    use({
      'ethanholz/nvim-lastplace',
      config = function()
        require('nvim-lastplace').setup({})
      end,
    })
    -- }}}

    -- Appearance {{{
    use({ 'stevearc/dressing.nvim' })
    use({
      'rcarriga/nvim-notify',
      config = function()
        vim.notify = require('notify')
      end,
    })
    use({ 'rmehri01/onenord.nvim' })
    use({
      'SmiteshP/nvim-gps',
      config = function()
        require('plugins.gps')
      end,
      module = 'nvim-gps',
    })
    use({
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('plugins.web-devicons')
      end,
    })
    use({
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('plugins.lualine')
      end,
    })
    use({
      'norcalli/nvim-colorizer.lua',
      cmd = 'ColorizerToggle',
      config = function()
        require('colorizer').setup()
      end,
    })
    -- }}}

    -- Editing {{{
    use({
      'folke/twilight.nvim',
      config = function()
        require('plugins.twilight')
      end,
      cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' },
    })
    use({ 'tpope/vim-abolish' })
    use({ 'tpope/vim-projectionist' })
    use({ 'tpope/vim-repeat' })
    use({ 'tpope/vim-sleuth' })
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('plugins.Comment')
      end,
    })
    use({
      'mattn/emmet-vim',
      keys = { { 'i', '<C-y>' } },
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
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'hrsh7th/cmp-cmdline' },
      },
      config = function()
        require('plugins.cmp')
      end,
    })
    use({
      'mhartington/formatter.nvim',
      module = 'formatter',
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
        require('plugins.gitsigns')
      end,
    })
    use({ 'tpope/vim-fugitive', cmd = { 'Git', 'G', 'Gread' } })
    -- }}}

    -- File Navigation {{{
    use({
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
      config = function()
        require('plugins.tree')
      end,
    })
    use({
      'nvim-telescope/telescope.nvim',
      config = function()
        require('plugins.telescope')
      end,
      cmd = { 'Telescope' },
      requires = {
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
    })
    -- }}}

    -- LSP {{{
    use({ 'folke/lua-dev.nvim' })
    use({ 'jose-elias-alvarez/nvim-lsp-ts-utils' })
    use({ 'kosayoda/nvim-lightbulb', module = 'nvim-lightbulb' })
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins.lspconfig')
      end,
    })
    use({
      'rmagatti/goto-preview',
      config = function()
        require('plugins.goto-preview')
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

    -- Syntax {{{
    use({ 'fladson/vim-kitty' })
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end,
      requires = {
        {
          'nvim-treesitter/playground',
          cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
        },
        { 'jackieaskins/nvim-ts-autotag' },
        { 'nvim-treesitter/nvim-treesitter-refactor' },
        { 'RRethy/nvim-treesitter-textsubjects' },
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 's1n7ax/nvim-comment-frame', module = 'nvim-comment-frame' },
      },
    })
    -- }}}

    -- Testing {{{
    use({
      'vim-test/vim-test',
      cmd = { 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' },
      config = function()
        require('plugins.test')
      end,
    })
    -- }}}
  end,
  config = {
    display = { prompt_border = 'rounded' },
  },
})

-- vim:foldmethod=marker
