local map = require('utils').map

require('hop').setup({})

map('n', '<leader><leader>', vim.cmd.HopChar1)
map('v', '<leader><leader>', vim.cmd.HopChar1Visual)
