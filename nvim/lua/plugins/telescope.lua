local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
local action_set = require('telescope.actions.set')

local packer_loader = require('packer').loader
packer_loader('telescope-fzf-native.nvim')
packer_loader('telescope-packer.nvim')

telescope.setup({
  defaults = {
    layout_strategy = 'flex',
    mappings = {
      i = {
        ['<Tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<Esc>'] = actions.close,
        ['<C-j>'] = function(prompt_bufnr)
          action_set.scroll_results(prompt_bufnr, 1)
        end,
        ['<C-k>'] = function(prompt_bufnr)
          action_set.scroll_results(prompt_bufnr, -1)
        end,
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

telescope.load_extension('fzf')
telescope.load_extension('packer')
