-- https://github.com/nvim-telescope/telescope.nvim

local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

local packer_loader = require('packer').loader
packer_loader('telescope-env.nvim')
packer_loader('telescope-fzf-native.nvim')

telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        mirror = true,
      },
      prompt_position = 'top',
    },
    path_display = { 'truncate' },
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
        ['<C-c>'] = action_layout.toggle_preview,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

telescope.load_extension('env')
telescope.load_extension('fzf')
