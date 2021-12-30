-- https://github.com/nathom/filetype.nvim

require('filetype').setup({
  overrides = {
    literal = {
      Brewfile_personal = 'ruby',
      ['tmux.conf'] = 'tmux',
      ['coc-settings.json'] = 'jsonc',
    },
    complex = {
      ['tmux/.*'] = 'tmux',
    },
  },
})
