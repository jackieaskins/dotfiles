return {
  {
    'MeanderingProgrammer/markdown.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true,
    ft = 'markdown',
  },
  {
    'NvChad/nvim-colorizer.lua',
    opts = { user_default_options = { AARRGGBB = true, names = false, tailwind = 'lsp' } },
  },
  { 'abecodes/tabout.nvim', config = true, dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'antonk52/markdowny.nvim', config = true, ft = 'markdown' },
  { 'axelvc/template-string.nvim', config = true },
  { 'chrisgrieser/nvim-early-retirement', config = true },
  { 'dmmulroy/tsc.nvim', cmd = 'TSC', opts = { pretty_errors = false } },
  { 'fladson/vim-kitty', ft = { 'kitty', 'kitty-session' } },
  {
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen' },
    opts = {
      outline_window = { auto_jump = true, hide_cursor = true },
    },
  },
  {
    'j-hui/fidget.nvim',
    opts = {
      notification = { window = { border = vim.g.border_style } },
      integration = { ['nvim-tree'] = { enable = false } },
    },
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
  {
    'luckasRanarison/tailwind-tools.nvim',
    config = true,
    ft = { 'css', 'hmtl', 'javascript', 'javascriptreact', 'svelte', 'typescriptreact', 'tsx' },
  },
  { 'matze/vim-move', keys = { '<M-h>', '<M-j>', '<M-k>', '<M-l>' } },
  { 'mcauley-penney/visual-whitespace.nvim', config = true },
  { 'nvim-treesitter/nvim-treesitter-context', opts = { multiline_threshold = 1 } },
  {
    'szw/vim-maximizer',
    init = function()
      vim.g.maximizer_set_default_mapping = 0
    end,
    keys = { { '<leader>mt', vim.cmd.MaximizerToggle, desc = 'MaximizerToggle' } },
  },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-surround' },
  { 'tzachar/highlight-undo.nvim', config = true, keys = { '<C-r>', 'u' } },
  { 'wintermute-cell/gitignore.nvim', cmd = 'Gitignore' },
}
