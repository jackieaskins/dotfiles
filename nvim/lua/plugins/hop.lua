-- https://github.com/phaazon/hop.nvim

local map = require('utils').map

require('hop').setup({})

map('n', '<leader><leader>', ':HopChar1<CR>')
map('v', '<leader><leader>', ':HopChar1Visual<CR>')
