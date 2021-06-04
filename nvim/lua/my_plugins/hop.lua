local map = require'my_utils'.map

require'hop'.setup {}

map('n', '<leader><leader>', ':HopChar1<CR>')
map('v', '<leader><leader>', ':HopChar1Visual<CR>')
