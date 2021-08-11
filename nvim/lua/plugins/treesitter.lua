require('nvim-treesitter.configs').setup({
  autotag = { enable = true, skip_close_shortcut = '\\>' },
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