-- https://github.com/s1n7ax/nvim-comment-frame

require('nvim-comment-frame').setup({
  keymap = '<leader>cf',
  multiline_keymap = '<leader>cF',
  languages = {
    tmux = { start_str = '#', end_str = '#' },
    vim = { start_str = '"', end_str = '"' },
    zsh = { start_str = '#', end_str = '#' },
  },
})
