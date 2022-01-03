-- https://github.com/phaazon/hop.nvim

local map = require('utils').map

require('hop').setup({})

map('n', '<leader><leader>', '<cmd>HopChar1<CR>')
map('v', '<leader><leader>', '<cmd>HopChar1Visual<CR>')
