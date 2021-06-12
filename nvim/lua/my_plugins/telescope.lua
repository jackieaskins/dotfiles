if vim.g.fuzzy_finder == 'telescope' then
  local actions = require('telescope.actions')
  local map = require('my_utils').map

  local mappings = {
    ['<Tab>'] = actions.toggle_selection + actions.move_selection_next,
    ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
  }

  require('telescope').setup {
    defaults = {
      layout_strategy = 'flex',
      prompt_position = 'top',
      sorting_strategy = 'ascending',
      mappings = {i = mappings, n = mappings},
    },
  }

  map('n', '<C-p>', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>')
  map('n', '<leader>/', '<cmd>Telescope live_grep<CR>')
  map('n', '<leader>f', '<cmd>Telescope grep_string<CR>')
  map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')

  map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
  map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
  map('n', 'gr', '<cmd>Telescope lsp_references<CR>')

  map('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>')
  map('v', '<leader>ca', '<cmd>Telescope lsp_range_code_actions<CR>')

  map('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
  map('n', '<leader>sd', '<cmd> Telescope lsp_document_symbols<CR>')
end
