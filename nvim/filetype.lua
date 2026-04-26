vim.filetype.add({
  extension = {
    gitconfig = 'gitconfig',
    tmTheme = 'xml',
    ['kitty-session'] = 'kitty',
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
