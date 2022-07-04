-- https://github.com/nvim-treesitter/nvim-treesitter

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'css',
    'dart',
    'go',
    'gomod',
    'graphql',
    'html',
    'java',
    'javascript',
    'json',
    'jsonc',
    'lua',
    'markdown',
    'perl',
    'python',
    'query',
    'ruby',
    'scss',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = { enable = true },
  indent = { enable = true },

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
        [']m'] = { '@function.outer', '@class.outer' },
      },
      goto_previous_start = {
        ['[m'] = { '@function.outer', '@class.outer' },
      },
      goto_next_end = {
        [']M'] = { '@function.outer', '@class.outer' },
      },
      goto_previous_end = {
        ['[M'] = { '@function.outer', '@class.outer' },
      },
    },
    select = {
      enable = true,
      keymaps = {
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
        ['aP'] = '@parameter.outer',
        ['iP'] = '@parameter.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = {
          '@parameter.inner',
          '@argument.inner',
        },
        ['<leader>A'] = {
          '@parameter.inner',
          '@argument.inner',
        },
      },
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
