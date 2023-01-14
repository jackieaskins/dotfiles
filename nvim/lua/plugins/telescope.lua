local M = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'danielvolchek/tailiscope.nvim' },
  },
  keys = {
    { '<leader>ht', '<cmd>Telescope help_tags<CR>' },
    { '<leader>hi', '<cmd>Telescope highlights<CR>' },
    { '<leader>km', '<cmd>Telescope keymaps<CR>' },
    { '<C-p>', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>' },
    { '<leader>ff', '<cmd>Telescope find_files find_command=rg,--no-ignore,--hidden,--files<CR>' },
    { '<leader>rg', ':Telescope grep_string search=', { silent = false } },
    { '<leader>/', '<cmd>Telescope live_grep only_sort_text=true<CR>' },
    { '<leader>fw', '<cmd>Telescope grep_string<CR>' },
    { '<leader>gs', '<cmd>Telescope git_status<CR>' },
    { '<leader>bu', '<cmd>Telescope buffers sort_mru=true<CR>' },
    { '<leader>of', '<cmd>Telescope oldfiles cwd_only=true sort_lastused=true include_current_session=true<CR>' },
    { '<leader>wd', '<cmd>Telescope diagnostics<CR>' },
    { '<leader>z=', '<cmd>Telescope spell_suggest<CR>' },
  },
}

function M.config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local action_layout = require('telescope.actions.layout')
  local action_set = require('telescope.actions.set')

  telescope.setup({
    defaults = {
      layout_strategy = 'vertical',
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
          ['<C-d>'] = false,
          ['<C-u>'] = false,
          ['<C-a>'] = actions.select_all,
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
  telescope.load_extension('notify')
end

return M
