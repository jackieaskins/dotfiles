return {
  { 'AckslD/messages.nvim', cmd = 'Messages', config = true },
  {
    'NvChad/nvim-colorizer.lua',
    opts = { user_default_options = { AARRGGBB = true, names = false, tailwind = 'lsp' } },
  },
  {
    'abecodes/tabout.nvim',
    config = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  { 'airblade/vim-matchquote', dependencies = { 'andymass/vim-matchup' } },
  {
    'akinsho/git-conflict.nvim',
    opts = {
      default_mappings = { ours = 'co', theirs = 'ct', none = 'c0', both = 'cb', next = ']x', prev = '[x' },
    },
  },
  { 'antonk52/markdowny.nvim', config = true, ft = 'markdown' },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-tree.lua' },
    config = true,
  },
  { 'axelvc/template-string.nvim', config = true },
  { 'chrisgrieser/nvim-early-retirement', config = true },
  { 'fladson/vim-kitty' },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    ft = 'markdown',
    keys = { { '<leader>mp', vim.cmd.MarkdownPreview, desc = 'MarkdownPreview' } },
  },
  { 'j-hui/fidget.nvim', opts = { text = { spinner = 'dots' } } },
  { 'lukas-reineke/indent-blankline.nvim', opts = { show_current_context = true } },
  { 'matze/vim-move', keys = { '<M-h>', '<M-j>', '<M-k>', '<M-l>' } },
  {
    'nvim-lua/plenary.nvim',
    config = function()
      require('plenary.filetype').add_file('extra')
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
    end,
  },
  { 'stevearc/dressing.nvim' },
  {
    'szw/vim-maximizer',
    init = function()
      vim.g.maximizer_set_default_mapping = 0
    end,
    keys = { { '<leader>mt', vim.cmd.MaximizerToggle, desc = 'MaximizerToggle' } },
  },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-fugitive', cmd = { 'Git', 'G', 'Gread' } },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-surround' },
  {
    'unblevable/quick-scope',
    init = function()
      vim.g.qs_buftype_blacklist = { 'terminal' }
      vim.g.qs_filetype_blacklist = { 'neo-tree', 'NvimTree' }
    end,
  },
  {
    'wintermute-cell/gitignore.nvim',
    requires = 'nvim-telescope/telescope.nvim',
    cmd = 'Gitignore',
  },
}
