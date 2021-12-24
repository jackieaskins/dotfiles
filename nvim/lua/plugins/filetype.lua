-- https://github.com/nathom/filetype.nvim

require('filetype').setup({
  overrides = {
    literal = {
      Brewfile_personal = 'ruby',
      ['tmux.conf'] = 'tmux',
    },
    complex = {
      ['tmux/.*'] = 'tmux',
    },
  },
})
