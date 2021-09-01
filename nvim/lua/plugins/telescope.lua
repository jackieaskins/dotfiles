local telescope = require('telescope')
local actions = require('telescope.actions')
local map = require('utils').map

telescope.setup({
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<Tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<Esc>'] = actions.close,
        ['<C-f>'] = actions.preview_scrolling_down,
        ['<C-b>'] = actions.preview_scrolling_up,
        ['<C-u>'] = false,
        ['<C-a>'] = { '<home>', type = 'command' },
        ['<C-e>'] = { '<end>', type = 'command' },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

telescope.load_extension('fzf')

map('n', '<C-p>', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>')
map('n', '<leader>/', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>rg', ':Telescope grep_string search=')
map('n', '<leader>f', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')

map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
map('n', 'gr', '<cmd>Telescope lsp_references<CR>')

map('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>')
map('v', '<leader>ca', '<cmd>Telescope lsp_range_code_actions<CR>')

map('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
map('n', '<leader>sd', '<cmd> Telescope lsp_document_symbols<CR>')