local opt = require'utils'.opt
local cmd = vim.cmd

opt('o', 'termguicolors', true)
vim.g.quantum_black = 1
cmd 'silent! colorscheme quantum'
