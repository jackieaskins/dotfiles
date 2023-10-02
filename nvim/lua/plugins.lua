return {
  { 'AckslD/messages.nvim', cmd = 'Messages', config = true },
  { 'FabijanZulj/blame.nvim', cmd = 'ToggleBlame' },
  {
    'NvChad/nvim-colorizer.lua',
    opts = { user_default_options = { AARRGGBB = true, names = false, tailwind = 'lsp' } },
  },
  {
    'altermo/ultimate-autopair.nvim',
    enabled = vim.g.use_ultimate_pairs,
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
      close = { enable = true },
      cr = { enable = true, autoclose = true },
      space2 = { enable = true },
      tabout = { enable = true, hopout = true, map = '<Tab>' },
    },
  },
  { 'antonk52/markdowny.nvim', config = true },
  { 'axelvc/template-string.nvim', config = true },
  { 'chrisgrieser/nvim-early-retirement', config = true },
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
    'jackieaskins/quick-scope',
    init = function()
      vim.g.qs_buftype_blacklist = { 'terminal' }
      vim.g.qs_filetype_blacklist = { 'neo-tree', 'NvimTree' }
    end,
  },
  {
    'kosayoda/nvim-lightbulb',
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true, hl = 'LightBulbVirtText' },
    },
  },
  { 'matze/vim-move', keys = { '<M-h>', '<M-j>', '<M-k>', '<M-l>' } },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({ timeout = 3000 })
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
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-surround' },
  { 'tzachar/highlight-undo.nvim', config = true },
  {
    'wintermute-cell/gitignore.nvim',
    requires = 'nvim-telescope/telescope.nvim',
    cmd = 'Gitignore',
  },
}
