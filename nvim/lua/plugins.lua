local map = require('utils').map

return {
  {
    'AckslD/messages.nvim',
    cmd = 'Messages',
    config = function()
      require('messages').setup()
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ user_default_options = { AARRGGBB = true, names = false, tailwind = 'lsp' } })
    end,
  },
  {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup()
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    init = function()
      map('n', '<leader>su', '<cmd>StartupTime --tries 20<CR>')
    end,
  },
  { 'fladson/vim-kitty' },
  {
    'gaoDean/autolist.nvim',
    config = function()
      require('autolist').setup({})
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    config = function()
      map('n', '<leader>mp', vim.cmd.MarkdownPreview)
    end,
    ft = 'markdown',
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({ show_current_context = true })
    end,
  },
  { 'matze/vim-move', keys = { '<M-h>', '<M-j>', '<M-k>', '<M-l>' } },
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
    config = function()
      vim.g.qs_buftype_blacklist = { 'terminal' }
      vim.g.qs_filetype_blacklist = { 'neo-tree' }
    end,
  },
  {
    'vigoux/notifier.nvim',
    config = function()
      require('notifier').setup({})
    end,
  },
}
