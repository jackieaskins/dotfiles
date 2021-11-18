local map = require('utils').map

require('luasnip/loaders/from_vscode').load({
  paths = { '~/dotfiles/vim-common' },
})

map('i', '<C-J>', '<cmd>lua require("luasnip").jump(1)<CR>')
map('i', '<C-K>', '<cmd>lua require("luasnip").jump(-1)<CR>')
map('s', '<C-J>', '<cmd>lua require("luasnip").jump(1)<CR>')
map('s', '<C-K>', '<cmd>lua require("luasnip").jump(-1)<CR>')
