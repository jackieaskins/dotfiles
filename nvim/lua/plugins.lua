return {
  { 'antonk52/markdowny.nvim', config = true, ft = 'markdown' },
  { 'axelvc/template-string.nvim', config = true },
  {
    'brenoprata10/nvim-highlight-colors',
    opts = { enable_named_colors = false, render = 'virtual' },
  },
  { 'chrisgrieser/nvim-early-retirement', opts = { notificationOnAutoClose = true } },
  {
    'danymat/neogen',
    opts = { snippet_engine = require('utils').get_snippet_engine() },
    cmd = 'Neogen',
  },
  { 'dmmulroy/tsc.nvim', cmd = 'TSC', opts = { pretty_errors = false } },
  { 'fladson/vim-kitty', ft = { 'kitty', 'kitty-session' } },
  { 'folke/ts-comments.nvim', config = true, event = 'VeryLazy' },
  {
    -- Switching to the lvim-tech fork until original is updated
    -- 'kosayoda/nvim-lightbulb',
    'lvim-tech/nvim-lightbulb',
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true, hl = 'LightBulbVirtText' },
    },
  },
  { 'm00qek/baleia.nvim' },
  { 'mcauley-penney/visual-whitespace.nvim', config = true },
  { 'nvim-treesitter/nvim-treesitter-context', opts = { multiline_threshold = 1 } },
  { 'nvim-zh/colorful-winsep.nvim', opts = { only_line_seq = false } },
  {
    'tomiis4/hypersonic.nvim',
    keys = { { '<leader>rx', '<cmd>Hypersonic<CR>' } },
    cmd = 'Hypersonic',
    opts = { border = vim.g.border_style },
  },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-surround' },
  { 'tzachar/highlight-undo.nvim', config = true, keys = { '<C-r>', 'u' } },
}
