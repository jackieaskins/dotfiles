local utils = require('utils')
local map = utils.map

-- Window Management
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

map('n', ']q', ':cnext')
map('n', '[q', ':cprevious')
