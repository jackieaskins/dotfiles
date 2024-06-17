return {
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
  {
    'mfussenegger/nvim-treehopper',
    keys = {
      { '.', ":<C-U>lua require('tsht').nodes()<CR>", mode = 'o', remap = true },
      { '.', ":lua require('tsht').nodes()<CR>", mode = 'x' },
    },
  },
  { 'nvim-treesitter/nvim-treesitter-context', opts = { multiline_threshold = 1 } },
  { 'nvim-zh/colorful-winsep.nvim', config = true },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-surround' },
  { 'tzachar/highlight-undo.nvim', config = true, keys = { '<C-r>', 'u' } },
}
