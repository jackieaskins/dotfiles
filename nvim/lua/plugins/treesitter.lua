require('nvim-treesitter.configs').setup({
  auto_install = true,
  ensure_installed = { 'comment', 'git_rebase', 'markdown_inline', 'regex' },
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

  -- https://github.com/andymass/vim-matchup
  matchup = {
    enable = true,
    disable_virtual_text = true,
  },

  -- https://github.com/nvim-treesitter/playground
  playground = { enable = true },

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
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
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
