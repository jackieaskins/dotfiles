local map = require('utils').map

-- Window Management
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Navigate Quickfix
map('n', '[q', ':cprevious<CR>')
map('n', ']q', ':cnext<CR>')
map('n', '[Q', ':cfirst<CR>')
map('n', ']Q', ':clast<CR>')
map('n', '[<C-Q>', ':cpfile<CR>')
map('n', ']<C-Q>', ':cpnile<CR>')

-- Plugins
-- FZF
map('n', '<C-p>', ':Files<CR>')
map('n', '<leader>/', ':Rg<space>')
map('n', '<leader>f', ':Rg<space><C-r><C-w><CR>')
map('n', '<leader>gs', ':GFiles?<CR>')

-- Reload
map('n', '<leader>rp', ':lua require("plugins.reload").reload_plugins()<CR>')
map('n', '<leader>re', ':Reload<CR>')

-- Startup Time
map('n', '<leader>su', ':StartupTime --tries 20<CR>')

-- Tree
map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<leader>n', ':NvimTreeFindFile<CR>')

-- Treesitter
map('n', '<leader>rn', '<cmd>lua require("plugins.treesitter-refactor").smart_rename()<CR>')
