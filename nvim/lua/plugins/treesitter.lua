-- https://github.com/nvim-treesitter/nvim-treesitter

require('nvim-treesitter.configs').setup({
  autotag = {
    enable = true,
    enable_rename = 'false', -- This doesn't work that well
    skip_close_shortcut = '\\>',
  },
  context_commentstring = { enable = true },
  ensure_installed = {
    'bash',
    'css',
    'dart',
    'graphql',
    'html',
    'java',
    'javascript',
    'json',
    'jsonc',
    'lua',
    'python',
    'query',
    'ruby',
    'scss',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = { enable = true },
  indent = { enable = true },
  playground = { enable = true },
  refactor = {
    highlight_definitions = { enable = true },
    navigation = { enable = true },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    },
  },
})
