local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'jackieaskins/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise',
    'RRethy/nvim-treesitter-textsubjects',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
}

function M.init()
  local map = require('utils').map

  local function goto_adjacent_usage(delta)
    return function()
      local bufnr = vim.api.nvim_get_current_buf()

      local ts_utils = require('nvim-treesitter.ts_utils')
      local locals = require('nvim-treesitter.locals')

      local node_at_point = ts_utils.get_node_at_cursor()
      if not node_at_point then
        return
      end

      local def_node, scope = locals.find_definition(node_at_point, bufnr)
      local usages = locals.find_usages(def_node, scope, bufnr)

      local index = nil
      for i, node in ipairs(usages) do
        if node == node_at_point then
          index = i
          break
        end
      end

      local target_index = (index + delta + #usages - 1) % #usages + 1
      ts_utils.goto_node(usages[target_index])
    end
  end

  map('n', '<M-8>', goto_adjacent_usage(1), { desc = 'Treesitter go to next usage' })
  map('n', '<M-3>', goto_adjacent_usage(-1), { desc = 'Treesitter go to previous usage' })
end

function M.config()
  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup({
    auto_install = true,
    ensure_installed = { 'bash', 'comment', 'git_rebase', 'gitcommit', 'markdown_inline', 'regex' },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-Space>',
        node_incremental = '<C-Space>',
        scope_incremental = '<C-S>',
        node_decremental = '<C-Backspace>',
      },
    },

    -- https://github.com/jackieaskins/nvim-ts-autotag
    autotag = {
      enable = true,
      enable_rename = 'false', -- Rename causes issues
      skip_close_shortcut = '\\>',
    },

    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },

    -- https://github.com/RRethy/nvim-treesitter-endwise
    endwise = {
      enable = true,
    },

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = {
            query = { '@function.outer', '@class.outer' },
            desc = 'Go to start of next function/class',
          },
        },
        goto_previous_start = {
          ['[m'] = {
            query = { '@function.outer', '@class.outer' },
            desc = 'Go to start of previous function/class',
          },
        },
        goto_next_end = {
          [']M'] = {
            query = { '@function.outer', '@class.outer' },
            desc = 'Go to end of next function/class',
          },
        },
        goto_previous_end = {
          ['[M'] = {
            query = { '@function.outer', '@class.outer' },
            desc = 'Go to end of previous function/class',
          },
        },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['aF'] = '@call.outer',
          ['iF'] = '@call.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
        },
      },
      swap = {
        enable = true,
        swap_next = { ['<leader>a'] = '@parameter.inner' },
        swap_previous = { ['<leader>A'] = '@parameter.inner' },
      },
    },

    -- https://github.com/RRethy/nvim-treesitter-textsubjects
    textsubjects = {
      enable = true,
      keymaps = {
        ['.'] = 'textsubjects-smart',
        ['a;'] = 'textsubjects-container-outer',
        ['i;'] = 'textsubjects-container-inner',
      },
    },
  })
end

return M
