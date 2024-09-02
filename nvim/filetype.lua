vim.filetype.add({
  extension = {
    conf = function(path)
      if path:match('tmux') then
        return 'tmux'
      end

      if path:match('kitty') then
        return 'kitty'
      end

      return 'conf'
    end,
    gitconfig = 'gitconfig',
    tmTheme = 'xml',
  },
  filename = {
    ['kitty.conf'] = 'kitty',
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
