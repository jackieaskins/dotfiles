require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'css',
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
  highlight = { enable = true }, -- TODO: Investigate lag on BufRead
  indent = { enable = true },
  playground = { enable = true },
  refactor = { highlight_definitions = { enable = true } },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    },
  },
})
