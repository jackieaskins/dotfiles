return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<C-n>', vim.cmd.NvimTreeToggle, desc = 'NvimTreeToggle' },
    { '<leader>n', vim.cmd.NvimTreeFindFileToggle, desc = 'NvimTreeFindFileToggle' },
  },
  opts = {
    actions = {
      open_file = { quit_on_open = true },
    },
    diagnostics = { enable = true, show_on_dirs = true },
    filters = {
      custom = { '*.meta' },
    },
    git = { ignore = false },
    renderer = {
      full_name = true,
      group_empty = true,
      highlight_git = true,
      icons = { git_placement = 'after' },
      indent_markers = { enable = true },
    },
    view = {
      centralize_selection = true,
      width = { max = 50 },
    },
  },
}
