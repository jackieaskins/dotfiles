---@type LazySpec
return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  cmd = 'FzfLua',
  keys = function()
    local keys = {
      -- Buffers and Files
      { '<leader>bu', 'buffers' },
      { '<C-p>', 'files' },
      { '<leader>of', 'oldfiles' },

      -- Search
      { '<leader>fw', 'grep_cword' },
      { '<leader>fW', 'grep_cWORD' },
      { '<leader>/', 'live_grep' },

      -- Git
      { '<leader>gs', 'git_status' },
      { '<leader>gl', 'git_commits' },
      { '<leader>gL', 'git_bcommits' },

      -- Diagnostics
      { '<leader>sd', 'lsp_document_symbols' },
      { '<leader>sw', 'lsp_workspace_symbols' },
      { '<leader>wd', 'diagnostics_workspace' },

      -- Misc
      { '<leader>.', 'resume' },
      { '<leader>ht', 'helptags' },
      { '<leader>hi', 'highlights' },
      { '<leader>au', 'autocmds' },
      { '<leader>km', 'keymaps' },
      { '<leader>z=', 'spell_suggest' },
    }

    return vim.tbl_map(function(map)
      return { map[1], '<cmd>FzfLua ' .. map[2] .. '<CR>' }
    end, keys)
  end,
  init = function()
    local utils = require('utils')

    utils.augroup('fzf_lsp_attach', {
      {
        'LspAttach',
        callback = function(args)
          local maps = {
            gr = 'lsp_references jump_to_single_result=true',
            gpr = 'lsp_references',
            gd = 'lsp_definitions jump_to_single_result=true',
            gpd = 'lsp_definitions',
            gi = 'lsp_implementations jump_to_single_result=true',
            gpi = 'lsp_implementations',
            ['g*'] = 'lsp_finder',
          }

          local bsk = utils.buffer_map(args.buf)
          for key, cmd in pairs(maps) do
            bsk('n', key, '<cmd>FzfLua ' .. cmd .. '<CR>')
          end
        end,
      },
    })
  end,
  opts = function()
    local actions = require('fzf-lua.actions')

    return {
      defaults = { file_icons = 'mini' },
      diagnostics = { cwd_only = true },
      file_ignore_patterns = { '^%.git/' },
      fzf_colors = true,
      fzf_opts = {
        ['--border'] = 'none',
        ['--cycle'] = true,
      },
      git = {
        status = {
          actions = {
            right = false,
            left = false,
            ['ctrl-space'] = { fn = actions.git_stage_unstage, reload = true },
          },
        },
      },
      grep = {
        rg_opts = table.concat({
          -- custom opts
          '--hidden',
          '-g="!.git"',
          -- default opts
          '--column',
          '--line-number',
          '--no-heading',
          '--color=always',
          '--smart-case',
          '--max-columns=4096',
          '-e',
        }, ' '),
      },
      keymap = {
        builtin = {
          true,
          ['<F1>'] = 'toggle-help',
          ['<F2>'] = 'toggle-fullscreen',
          ['<C-c>'] = 'toggle-preview',
          ['<C-f>'] = 'preview-page-down',
          ['<C-b>'] = 'preview-page-up',
        },
        fzf = {
          true,
          ['alt-a'] = 'toggle-all',
          ['ctrl-q'] = 'select-all+accept',
          ['ctrl-c'] = 'toggle-preview',
          ['ctrl-a'] = 'beginning-of-line',
          ['ctrl-e'] = 'end-of-line',
          ['ctrl-f'] = 'preview-page-down',
          ['ctrl-b'] = 'preview-page-up',
        },
      },
      lsp = {
        code_actions = { previewer = 'codeaction_native' },
        ignore_current_line = true,
        includeDeclaration = false,
      },
      oldfiles = { cwd_only = true, include_current_session = true },
      previewers = {
        git_diff = { pager = 'delta --file-style="omit"' },
      },
      winopts = {
        backdrop = 100,
        border = MY_CONFIG.border_style,
        preview = {
          border = 'border-' .. MY_CONFIG.border_style,
          wrap = 'wrap',
          flip_columns = 160,
        },
      },
    }
  end,
}
