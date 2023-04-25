vim.filetype.add({
  filename = {
    Brewfile = 'ruby',
    ['tmux.conf'] = 'tmux',
    ['coc-settings.json'] = 'jsonc',
    ['.eslintrc.json'] = 'jsonc',
  },
  pattern = {
    ['jdt://.*'] = 'java',
    ['tmux/.*%.conf'] = 'tmux',
    ['tsconfig.*%.json'] = 'jsonc',
    ['%.env.*'] = 'sh',
  },
})
