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
    use({ 'lewis6991/impatient.nvim' })
    use({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
    use({
      'preservim/vimux',
      cmd = { 'VimuxRunCommand', 'VimuxOpenRunner' },
      config = 'require("plugins.vimux")',
      fn = { 'VimuxClearTerminalScreen', 'VimuxClearRunnerHistory', 'VimuxRunCommand', 'VimuxOpenRunner' },
    })
    use({ 'alexghergh/nvim-tmux-navigation', config = 'require("plugins.tmux-navigation")' })
    use({ 'szw/vim-maximizer', cmd = 'MaximizerToggle', config = 'require("plugins.maximizer")' })
    use({ 'AckslD/messages.nvim', config = 'require("messages").setup()' })
    use({
      'bennypowers/nvim-regexplainer',
      config = 'require("regexplainer").setup()',
      requires = { 'nvim-treesitter/nvim-treesitter', 'MunifTanjim/nui.nvim' },
    })
    -- }}}

    -- Appearance {{{
    use({ 'stevearc/dressing.nvim' })
    use({ 'catppuccin/nvim', as = 'catppuccin' })
    use({ 'levouh/tint.nvim', config = 'require("plugins.tint")' })
    use({ 'nvim-treesitter/nvim-treesitter-context', config = 'require("plugins.treesitter-context")' })
    use({ 'nvim-tree/nvim-web-devicons', config = 'require("plugins.web-devicons")' })
    use({ 'feline-nvim/feline.nvim', config = 'require("plugins.feline")' })
    use({ 'NvChad/nvim-colorizer.lua', config = 'require("plugins.colorizer")' })
    use({ 'lukas-reineke/indent-blankline.nvim', config = 'require("plugins.indent-blankline")' })
    use({ 'anuvyklack/pretty-fold.nvim', config = 'require("pretty-fold").setup()' })
    -- }}}

    -- Editing {{{
    use({ 'axelvc/template-string.nvim', config = 'require("plugins.template-string")' })
    use({ 'johmsalas/text-case.nvim', config = 'require("textcase").setup({})' })
    use({ 'tpope/vim-projectionist', config = 'require("plugins.projectionist")' })
    use({ 'tpope/vim-repeat' })
    use({ 'tpope/vim-sleuth' })
    use({
      's1n7ax/nvim-comment-frame',
      config = 'require("plugins.comment-frame")',
      keys = { '<leader>cf', '<leader>cF' },
      requires = 'nvim-treesitter',
    })
    use({ 'numToStr/Comment.nvim', config = 'require("plugins.Comment")' })
    use({ 'axelf4/vim-strip-trailing-whitespace' })
    use({ 'iamcco/markdown-preview.nvim', ft = 'markdown', run = 'cd app && npm install' })
    use({ 'L3MON4D3/LuaSnip', bufread = false, config = 'require("plugins.LuaSnip")', module = 'luasnip' })
    use({
      'hrsh7th/nvim-cmp',
      config = 'require("plugins.cmp")',
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
    use({ 'sbdchd/neoformat', cmd = 'Neoformat', config = 'require("plugins.neoformat")' })
    use({ 'mfussenegger/nvim-lint', config = 'require("plugins.lint")', module = 'lint' })
    use({ 'gaoDean/autolist.nvim', config = 'require("autolist").setup({})', ft = 'markdown' })
    use({
      'narutoxy/dim.lua',
      config = 'require("dim").setup({})',
      requires = { 'nvim-treesitter/nvim-treesitter', 'neovim/nvim-lspconfig' },
    })
    -- }}}

    -- Surround {{{
    use({ 'andymass/vim-matchup', config = 'require("plugins.matchup")' })
    use({ 'Wansmer/treesj', cmd = { 'TSJJoin', 'TSJSplit' }, config = 'require("plugins.treesj")' })
    use({ 'tpope/vim-surround' })
    use({ 'windwp/nvim-autopairs', config = 'require("plugins.autopairs")' })
    use({ 'abecodes/tabout.nvim', config = 'require("tabout").setup()' })
    -- }}}

    -- Git {{{
    use({ 'rhysd/committia.vim', config = 'require("plugins.committia")' })
    use({ 'rhysd/conflict-marker.vim' })
    use({ 'lewis6991/gitsigns.nvim', config = 'require("plugins.gitsigns")', requires = 'nvim-lua/plenary.nvim' })
    use({ 'tpope/vim-fugitive', bufread = false, cmd = { 'Git', 'G', 'Gread' } })
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
      cmd = 'Neotree',
      config = 'require("plugins.neo-tree")',
      requires = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
    })
    use({
      'nvim-telescope/telescope.nvim',
      bufread = false,
      cmd = 'Telescope',
      config = 'require("plugins.telescope")',
      module = 'telescope',
      requires = {
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', opt = true },
        { 'nvim-telescope/telescope-packer.nvim', opt = true },
        { 'danielvolchek/tailiscope.nvim', opt = true },
      },
    })
    -- }}}

    -- LSP {{{
    use({ 'folke/neodev.nvim' })
    use({ 'kosayoda/nvim-lightbulb', config = 'require("plugins.lightbulb")' })
    use({
      'neovim/nvim-lspconfig',
      config = 'require("plugins.lspconfig")',
      requires = { 'jose-elias-alvarez/typescript.nvim', 'folke/neodev.nvim' },
    })
    use({ 'rmagatti/goto-preview', config = 'require("plugins.goto-preview")', keys = { 'gpd', 'gpi', 'gpr', 'gP' } })
    use({ 'j-hui/fidget.nvim', config = 'require("plugins.fidget")' })
    -- }}}

    -- Movement {{{
    use({ 'unblevable/quick-scope', config = 'require("plugins.quick-scope")' })
    use({ 'matze/vim-move' })
    -- }}}

    -- Syntax {{{
    use({ 'fladson/vim-kitty' })
    use({
      'nvim-treesitter/nvim-treesitter',
      config = 'require("plugins.treesitter")',
      requires = {
        'nvim-treesitter/playground',
        local_plugin('nvim-ts-autotag'),
        'RRethy/nvim-treesitter-textsubjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'RRethy/nvim-treesitter-endwise',
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      run = ':TSUpdate',
    })
    use({ 'ziontee113/query-secretary', module = 'query-secretary' })
    -- }}}

    -- Testing {{{
    use({ 'nvim-neotest/neotest', bufread = false, config = 'require("plugins.neotest")', module = 'neotest' })
    -- }}}
  end,
  config = {
    display = { prompt_border = 'rounded' },
    max_jobs = 10,
  },
})

-- vim:foldmethod=marker
