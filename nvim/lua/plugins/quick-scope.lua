local utils = require'utils'
local augroup,map = utils.augroup,utils.map

augroup('quick_scope', {
  {'ColorScheme', '*', 'highlight QuickScopePrimary guifg=#ff007c'},
  {'ColorScheme', '*', 'highlight QuickScopeSecondary guifg=#00dfff'}
})

vim.g.qs_enable = 0

map('n', '<leader>qs', '<cmd>QuickScopeToggle<CR>')
map('x', '<leader>qs', '<cmd>(QuickScopeToggle)<CR>')
