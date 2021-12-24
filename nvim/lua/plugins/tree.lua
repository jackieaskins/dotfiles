-- https://github.com/kyazdani42/nvim-tree.lua

vim.g.nvim_tree_quit_on_open = 1
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
})
