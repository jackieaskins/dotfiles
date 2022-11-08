-- https://github.com/neovim/neovim/pull/16600

vim.filetype.add({
  filename = {
    Brewfile = 'ruby',
    Brewfile_personal = 'ruby',
    ['tmux.conf'] = 'tmux',
    ['coc-settings.json'] = 'jsonc',
    ['.eslintrc.json'] = 'jsonc',
    ['gitmux.conf'] = 'yaml',
  },
  pattern = {
    ['jdt://.*'] = 'java',
    ['tmux/.*%.conf'] = 'tmux',
    ['tsconfig.*%.json'] = 'jsonc',
  },
})
