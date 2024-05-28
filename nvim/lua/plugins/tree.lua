local diagnostic_icons = require('diagnostic.icons')

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      'antosha417/nvim-lsp-file-operations',
      config = true,
      dependencies = 'nvim-lua/plenary.nvim',
    },
  },
  keys = {
    { '<C-n>', vim.cmd.NvimTreeToggle, desc = 'NvimTreeToggle' },
    { '<leader>n', vim.cmd.NvimTreeFindFileToggle, desc = 'NvimTreeFindFileToggle' },
  },
  opts = {
    actions = {
      open_file = { quit_on_open = true },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = diagnostic_icons.HINT,
        info = diagnostic_icons.INFO,
        warning = diagnostic_icons.WARN,
        error = diagnostic_icons.ERROR,
      },
    },
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
