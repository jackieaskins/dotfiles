-- https://github.com/vim-test/vim-test

local g = vim.g

g['test#strategy'] = 'kitty'
g['test#neovim#term_position'] = 'vert botright'
g['test#javascript#jest#options'] = '--watch'
