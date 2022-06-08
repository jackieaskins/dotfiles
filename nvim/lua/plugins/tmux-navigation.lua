-- https://github.com/alexghergh/nvim-tmux-navigation

require('nvim-tmux-navigation').setup({
  disable_when_zoomed = true,
  keybindings = {
    left = '<C-h>',
    down = '<C-j>',
    up = '<C-k>',
    right = '<C-l>',
  },
})
