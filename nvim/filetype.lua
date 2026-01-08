vim.filetype.add({
  extension = {
    gitconfig = 'gitconfig',
    tmTheme = 'xml',
  },
  filename = {
    Brewfile = 'ruby',
    gitignore_global = 'gitignore',
  },
  pattern = {
    ['jdt://.*'] = 'java',
    ['%.env.*'] = 'sh',
  },
})
