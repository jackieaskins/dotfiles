-- https://github.com/kyazdani42/nvim-tree.lua

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_group_empty = 1

require('nvim-tree').setup({
  auto_close = false,
  signcolumn = 'no',
  view = {
    width = 50,
  },
  git = {
    ignore = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})
