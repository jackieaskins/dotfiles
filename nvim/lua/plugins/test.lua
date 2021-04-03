local map = require'utils'.map
local g = vim.g

g['test#strategy'] = 'neovim'
g['test#neovim#term_position'] = 'vert botright'

g['test#java#runner'] = 'gradletest'
g['test#typescript#jest#options'] = '--no-coverage --watch'
g['test#javascript#jest#options'] = '--no-coverage --watch'

map('n', '<leader>tn', '<cmd>TestNearest<CR>')
map('n', '<leader>tf', '<cmd>TestFile<CR>')
map('n', '<leader>ts', '<cmd>TestSuite<CR>')
map('n', '<leader>tl', '<cmd>TestLast<CR>')
map('n', '<leader>tv', '<cmd>TestVisit<CR>')
