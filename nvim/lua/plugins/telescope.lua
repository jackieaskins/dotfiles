local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'benfowler/telescope-luasnip.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'danielvolchek/tailiscope.nvim' },
    { 'tsakirist/telescope-lazy.nvim' },
    { 'isak102/telescope-git-file-history.nvim', dependencies = 'tpope/vim-fugitive' },
  },
  cmd = 'Telescope',
  event = 'LspAttach',
  keys = {
    { '<leader>ht', '<cmd>Telescope help_tags<CR>' },
    { '<leader>hi', '<cmd>Telescope highlights<CR>' },
    { '<leader>km', '<cmd>Telescope keymaps<CR>' },
    { '<C-p>', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>' },
    { '<leader>ff', '<cmd>Telescope find_files find_command=rg,--no-ignore,--hidden,--files<CR>' },
    { '<leader>rg', ':Telescope grep_string search=', { silent = false } },
    { '<leader>lg', '<cmd>Telescope live_grep only_sort_text=true<CR>' },
    { '<leader>/', '<cmd>Telescope live_grep<CR>' },
    { '<leader>fw', '<cmd>Telescope grep_string<CR>' },
    { '<leader>bu', '<cmd>Telescope buffers sort_mru=true<CR>' },
    { '<leader>of', '<cmd>Telescope oldfiles cwd_only=true sort_lastused=true include_current_session=true<CR>' },
    { '<leader>wd', '<cmd>Telescope diagnostics<CR>' },
    { '<leader>we', '<cmd>Telescope diagnostics severity_limit=' .. vim.diagnostic.severity.E .. '<CR>' },
    { '<leader>z=', '<cmd>Telescope spell_suggest<CR>' },
    { '<leader>sn', '<cmd>Telescope luasnip<CR>' },

    { '<leader>la', '<cmd>Telescope lazy<CR>' },

    -- Git commands
    { '<leader>gs', '<cmd>Telescope git_status<CR>' },
    { '<leader>gl', '<cmd>Telescope git_commits<CR>' },
    { '<leader>gL', '<cmd>Telescope git_bcommits<CR>' },
    { '<leader>gh', '<cmd>Telescope git_file_history<CR>' },

    -- Workspace symbols
    { '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>' },
    { '<leader>sd', '<cmd>Telescope lsp_document_symbols symbols=constant,function,method<CR>' },
  },
}

local function configure_lsp_keymaps()
  local utils = require('utils')

  utils.augroup('telescope_lsp_attach', {
    {
      'LspAttach',
      callback = function(args)
        local bsk = utils.buffer_map(args.buf)

        bsk('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
        bsk('n', 'gpi', '<cmd>Telescope lsp_implementations jump_type=never<CR>')
        bsk('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
        bsk('n', 'gpd', '<cmd>Telescope lsp_definitions jump_type=never<CR>')
        bsk('n', 'gr', '<cmd>Telescope lsp_references include_declaration=false<CR>')
        bsk('n', 'gpr', '<cmd>Telescope lsp_references include_declaration=false jump_type=never<CR>')
      end,
    },
  })
end

local function get_border()
  local bs = vim.g.border_style

  if type(bs) ~= 'table' then
    vim.notify('Telescope border style could not be configured, falling back to default')
    return nil
  end

  return { bs[2], bs[4], bs[6], bs[8], bs[1], bs[3], bs[5], bs[7] }
end

function M.config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local action_layout = require('telescope.actions.layout')
  local action_set = require('telescope.actions.set')

  local default_file_ignore_patterns = { '.git/', 'build/', 'dist/' }

  local layout_col_cutoff = 110

  telescope.setup({
    defaults = {
      borderchars = get_border(),
      dynamic_preview_title = true,
      file_ignore_patterns = default_file_ignore_patterns,
      layout_config = {
        flex = { flip_columns = layout_col_cutoff },
        prompt_position = 'top',
        vertical = { mirror = true },
        horizontal = { preview_cutoff = layout_col_cutoff },
      },
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
          ['<C-d>'] = false,
          ['<C-u>'] = false,
          ['<C-a>'] = actions.select_all,
          ['<C-e>'] = { '<end>', type = 'command' },
          ['<C-c>'] = action_layout.toggle_preview,
        },
      },
      path_display = { 'truncate' },
      prompt_prefix = '   ',
      entry_prefix = '  ',
      selection_caret = ' ',
      sorting_strategy = 'ascending',
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
    pickers = {
      find_files = {
        file_ignore_patterns = vim.tbl_extend('keep', default_file_ignore_patterns, { 'node_modules/*' }),
        live_grep = vim.tbl_extend('keep', default_file_ignore_patterns, { 'package_lock.json' }),
      },
    },
  })

  telescope.load_extension('dap')
  telescope.load_extension('fzf')
  telescope.load_extension('git_file_history')
  telescope.load_extension('lazy')
  telescope.load_extension('luasnip')
  telescope.load_extension('notify')

  configure_lsp_keymaps()
end

return M
