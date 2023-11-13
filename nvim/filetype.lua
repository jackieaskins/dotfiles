vim.filetype.add({
  filename = {
    Brewfile = 'ruby',
    ['tmux.conf'] = 'tmux',
    ['coc-settings.json'] = 'jsonc',
    ['.eslintrc.json'] = 'jsonc',
    ['kitty.conf'] = 'kitty',
  },
  pattern = {
    ['jdt://.*'] = 'java',
    ['tmux/.*%.conf'] = 'tmux',
    ['tsconfig.*%.json'] = 'jsonc',
    ['%.env.*'] = 'sh',
    ['kitty/.*%.conf'] = 'kitty',
    ['kitty/.*%.session'] = 'kitty-session',
  },
})
