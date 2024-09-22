vim.filetype.add({
  extension = {
    gitconfig = 'gitconfig',
    tmTheme = 'xml',
  },
  filename = {
    Brewfile = 'ruby',
    gitignore_global = 'gitignore',
    ['coc-settings.json'] = 'jsonc',
    ['.eslintrc.json'] = 'jsonc',
  },
  pattern = {
    ['jdt://.*'] = 'java',
    ['tsconfig.*%.json'] = 'jsonc',
    ['%.env.*'] = 'sh',
  },
})
