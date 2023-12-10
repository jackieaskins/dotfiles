return {
  { 'AckslD/messages.nvim', cmd = 'Messages', config = true },
  {
    'NvChad/nvim-colorizer.lua',
    opts = { user_default_options = { AARRGGBB = true, names = false, tailwind = 'lsp' } },
  },
  { 'antonk52/markdowny.nvim', config = true, ft = 'markdown' },
  { 'axelvc/template-string.nvim', config = true },
  { 'chrisgrieser/nvim-early-retirement', config = true },
  { 'fladson/vim-kitty', ft = { 'kitty', 'kitty-session' } },
  {
    'j-hui/fidget.nvim',
    opts = { notification = { window = { border = vim.g.border_style } } },
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
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'stevearc/dressing.nvim',
    opts = {
      input = { border = vim.g.border_style },
      select = { telescope = { layout_config = { width = 80, height = 20 } } },
    },
  },
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
  { 'tzachar/highlight-undo.nvim', config = true, keys = { '<C-r>', 'u' } },
  {
    'wintermute-cell/gitignore.nvim',
    requires = 'nvim-telescope/telescope.nvim',
    cmd = 'Gitignore',
  },
}
