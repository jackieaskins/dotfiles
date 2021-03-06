local g = vim.g
local map = require'my_utils'.map

g.nvim_tree_disable_netrw = 0
g.nvim_tree_git_hl = 1
g.nvim_tree_group_empty = 1
g.nvim_tree_hijack_netrw = 0
g.nvim_tree_ignore = {'.git', 'node_modules', '.DS_Store'}
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_width = 50

map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<leader>n', ':NvimTreeFindFile<CR>')
