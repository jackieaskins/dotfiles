local map = require('utils').map

return {
  { 'AckslD/messages.nvim', cmd = 'Messages', config = true },
  {
    'NvChad/nvim-colorizer.lua',
    config = { user_default_options = { AARRGGBB = true, names = false, tailwind = 'lsp' } },
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
    config = function()
      map('n', '<leader>mp', vim.cmd.MarkdownPreview)
    end,
    ft = 'markdown',
  },
  { 'j-hui/fidget.nvim', config = { text = { spinner = 'dots' } } },
  { 'lukas-reineke/indent-blankline.nvim', config = { show_current_context = true } },
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
  { 'stevearc/dressing.nvim', event = 'VeryLazy' },
  {
    'szw/vim-maximizer',
    cmd = 'MaximizerToggle',
    init = function()
      vim.g.maximizer_set_default_mapping = 0
      map('n', '<leader>mt', vim.cmd.MaximizerToggle)
    end,
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
