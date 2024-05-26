return {
  { 'abecodes/tabout.nvim', config = true, dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'antonk52/markdowny.nvim', config = true, ft = 'markdown' },
  { 'axelvc/template-string.nvim', config = true },
  {
    'brenoprata10/nvim-highlight-colors',
    opts = { enable_tailwind = true, enable_named_colors = false },
  },
  { 'chrisgrieser/nvim-early-retirement', config = true },
  { 'dmmulroy/tsc.nvim', cmd = 'TSC', opts = { pretty_errors = false } },
  { 'fladson/vim-kitty', ft = { 'kitty', 'kitty-session' } },
  { 'folke/ts-comments.nvim', config = true, event = 'VeryLazy' },
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
  {
    'luckasRanarison/tailwind-tools.nvim',
    config = true,
    ft = { 'css', 'hmtl', 'javascript', 'javascriptreact', 'svelte', 'typescriptreact', 'tsx' },
  },
  { 'mcauley-penney/visual-whitespace.nvim', config = true },
  { 'nvim-treesitter/nvim-treesitter-context', opts = { multiline_threshold = 1 } },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-surround' },
  { 'tzachar/highlight-undo.nvim', config = true, keys = { '<C-r>', 'u' } },
}
