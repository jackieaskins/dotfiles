return {
  { 'AckslD/messages.nvim', cmd = 'Messages', config = true },
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = { AARRGGBB = true, names = false, tailwind = 'lsp' },
    },
  },
  { 'abecodes/tabout.nvim', config = true, dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'antonk52/markdowny.nvim', config = true, ft = 'markdown' },
  { 'axelvc/template-string.nvim', config = true },
  { 'chrisgrieser/nvim-early-retirement', config = true },
  { 'dawsers/edit-code-block.nvim', config = true, cmd = 'EditCodeBlock' },
  { 'fladson/vim-kitty' },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    ft = 'markdown',
    keys = { { '<leader>mp', vim.cmd.MarkdownPreview, desc = 'MarkdownPreview' } },
  },
  {
    'j-hui/fidget.nvim',
    opts = { text = { spinner = 'dots' } },
    -- https://github.com/j-hui/fidget.nvim/issues/131
    tag = 'legacy',
  },
  {
    'kosayoda/nvim-lightbulb',
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true, hl_mode = 'combine' },
    },
  },
  { 'lukas-reineke/indent-blankline.nvim', opts = { show_current_context = true } },
  { 'matze/vim-move', keys = { '<M-h>', '<M-j>', '<M-k>', '<M-l>' } },
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
  { 'tzachar/highlight-undo.nvim', opts = { hlgroup = 'IncSearch' } },
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
