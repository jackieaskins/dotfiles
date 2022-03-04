vim.g.do_filetype_lua = 1
vim.filetype.add({
  filename = {
    Brewfile = 'ruby',
    Brewfile_personal = 'ruby',
    ['tmux.conf'] = 'tmux',
    ['coc-settings.json'] = 'jsonc',
    ['.eslintrc.json'] = 'jsonc',
    ['package.json'] = 'jsonc',
    ['gitmux.conf'] = 'yaml',
  },
  pattern = {
    ['tmux/.*%.conf'] = 'tmux',
    ['tsconfig.*%.json'] = 'jsonc',
  },
})
