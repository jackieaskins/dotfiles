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
