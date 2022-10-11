local file_exists = require('utils').file_exists

vim.cmd.packadd('packer.nvim')

local function local_plugin(name)
  local prefix = vim.g.is_personal_machine and '~/vim-plugins/' or 'jackieaskins/'
  return prefix .. name
end

return require('packer').startup({
  function(use)
    use({ 'wbthomason/packer.nvim', opt = true })

    if file_exists('~/dotfiles/nvim/lua/custom/plugins.lua') then
      require('custom.plugins')(use)
    end

    -- Dev Tools {{{
    use({ 'milisims/nvim-luaref' })
    use({ 'lewis6991/impatient.nvim' })
    use({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
    use({
      'preservim/vimux',
      cmd = { 'VimuxRunCommand', 'VimuxOpenRunner' },
      config = function()
        require('plugins.vimux')
      end,
      fn = {
        'VimuxClearTerminalScreen',
        'VimuxClearRunnerHistory',
        'VimuxRunCommand',
        'VimuxOpenRunner',
      },
    })
    use({
      'alexghergh/nvim-tmux-navigation',
      config = function()
        require('plugins.tmux-navigation')
      end,
    })
    use({
      'szw/vim-maximizer',
      cmd = 'MaximizerToggle',
      config = function()
        require('plugins.maximizer')
      end,
    })
    use({
      'rktjmp/shipwright.nvim',
      cmd = 'Shipwright',
      module = 'shipwright',
    })
    -- }}}

    -- Appearance {{{
    use({ 'stevearc/dressing.nvim' })
    use({
      'rmehri01/onenord.nvim',
      run = function()
        require('packer').loader('shipwright.nvim')
        require('shipwright').build('nvim/lua/plugins/shipwright.lua')
      end,
    })
    use({
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require('treesitter-context').setup()
      end,
    })
    use({
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('plugins.web-devicons')
      end,
    })
    use({
      'feline-nvim/feline.nvim',
      config = function()
        require('plugins.feline')
      end,
    })
    use({
      'NvChad/nvim-colorizer.lua',
      config = function()
        require('plugins.colorizer')
      end,
    })
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('plugins.indent-blankline')
      end,
    })
    -- }}}

    -- Editing {{{
    use({
      'axelvc/template-string.nvim',
      config = function()
        require('plugins.template-string')
      end,
    })
    use({ 'tpope/vim-abolish' })
    use({
      'tpope/vim-projectionist',
      config = function()
        require('plugins.projectionist')
      end,
    })
    use({ 'tpope/vim-repeat' })
    use({ 'tpope/vim-sleuth' })
    use({
      's1n7ax/nvim-comment-frame',
      config = function()
        require('plugins.comment-frame')
      end,
      keys = { '<leader>cf', '<leader>cF' },
      requires = 'nvim-treesitter',
    })
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('plugins.Comment')
      end,
    })
    use({ 'axelf4/vim-strip-trailing-whitespace' })
    use({
      'iamcco/markdown-preview.nvim',
      ft = 'markdown',
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
      config = function()
        require('plugins.cmp')
      end,
      requires = {
        { local_plugin('cmp-emmet'), run = 'npm run release' },
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
      },
    })
    use({ 'mhartington/formatter.nvim', module = 'formatter' })
    use({
      'mizlan/iswap.nvim',
      cmd = { 'ISwap', 'ISwapWith', 'ISwapWithLeft', 'ISwapWithRight' },
    })
    use({
      'gaoDean/autolist.nvim',
      ft = 'markdown',
      config = function()
        require('autolist').setup({})
      end,
    })
    -- }}}

    -- Surround {{{
    use({
      'andymass/vim-matchup',
      config = function()
        require('plugins.matchup')
      end,
    })
    use({
      'AndrewRadev/splitjoin.vim',
      config = function()
        require('plugins.splitjoin')
      end,
    })
    use({ 'tpope/vim-surround' })
    use({
      'ZhiyuanLck/smart-pairs',
      config = function()
        require('plugins.smart-pairs')
      end,
    })
    use({
      'abecodes/tabout.nvim',
      config = function()
        require('tabout').setup()
      end,
    })
    -- }}}

    -- Git {{{
    use({
      'rhysd/committia.vim',
      config = function()
        require('plugins.committia')
      end,
    })
    use({ 'rhysd/conflict-marker.vim' })
    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('plugins.gitsigns')
      end,
      requires = 'nvim-lua/plenary.nvim',
    })
    use({ 'tpope/vim-fugitive', cmd = { 'Git', 'G', 'Gread' } })
    use({
      'sindrets/diffview.nvim',
      cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
      requires = 'nvim-lua/plenary.nvim',
    })
    -- }}}

    -- File Navigation {{{
    use({
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      config = function()
        require('plugins.neo-tree')
      end,
      requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
    })
    use({
      'nvim-telescope/telescope.nvim',
      bufread = false,
      cmd = 'Telescope',
      config = function()
        require('plugins.telescope')
      end,
      module = 'telescope',
      requires = {
        { 'LinArcX/telescope-env.nvim', opt = true },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', opt = true },
        { 'nvim-telescope/telescope-packer.nvim', opt = true },
      },
    })
    -- }}}

    -- LSP {{{
    use({ 'folke/lua-dev.nvim' })
    use({
      'kosayoda/nvim-lightbulb',
      config = function()
        require('plugins.lightbulb')
      end,
    })
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins.lspconfig')
      end,
      requires = 'jose-elias-alvarez/typescript.nvim',
    })
    use({
      'rmagatti/goto-preview',
      config = function()
        require('plugins.goto-preview')
      end,
      keys = { 'gpd', 'gpi', 'gpr', 'gP' },
    })
    use({
      'j-hui/fidget.nvim',
      config = function()
        require('plugins.fidget')
      end,
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
    -- }}}

    -- Syntax {{{
    use({ 'fladson/vim-kitty' })
    use({
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('plugins.treesitter')
      end,
      requires = {
        {
          'nvim-treesitter/playground',
          cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
        },
        local_plugin('nvim-ts-autotag'),
        'RRethy/nvim-treesitter-textsubjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'RRethy/nvim-treesitter-endwise',
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      run = ':TSUpdate',
    })
    -- }}}

    -- Testing {{{
    use({
      'nvim-neotest/neotest',
      config = function()
        require('plugins.neotest')
      end,
      module = 'neotest',
    })
    -- }}}
  end,
  config = {
    display = { prompt_border = 'rounded' },
  },
})

-- vim:foldmethod=marker
