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
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    config = function()
      require('nvim-treesitter.configs').setup({ playground = { enable = true } })
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
    end,
  },
  { 'rhysd/conflict-marker.vim' },
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
      vim.g.qs_filetype_blacklist = { 'neo-tree' }
    end,
  },
}
