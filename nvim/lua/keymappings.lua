local utils = require('utils')
local augroup, map = utils.augroup, utils.map

-- Window Management
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Navigate Quickfix
map('n', '[q', '<cmd>cprevious<CR>')
map('n', ']q', '<cmd>cnext<CR>')
map('n', '[Q', '<cmd>cfirst<CR>')
map('n', ']Q', '<cmd>clast<CR>')
map('n', '[<C-q>', '<cmd>cpfile<CR>')
map('n', ']<C-q>', '<cmd>cnfile<CR>')

-- Navigate Location List
map('n', '[l', '<cmd>lprevious<CR>')
map('n', ']l', '<cmd>lnext<CR>')
map('n', '[L', '<cmd>lfirst<CR>')
map('n', ']L', '<cmd>llast<CR>')
map('n', '[<C-l>', '<cmd>lpfile<CR>')
map('n', ']<C-l>', '<cmd>lnfile<CR>')

map('n', '<leader>so', '<cmd>luafile %<CR>')
map('n', '<leader>rp', '<cmd>lua require("reload").reload_plugins()<CR>')

map('n', '<leader>rn', '<cmd>lua require("rename").smart_rename()<CR>')

-- Plugins
-- Comment Frame
map('n', '<leader>cf', '<cmd>lua require("nvim-comment-frame").add_multiline_comment()<CR>')

-- Maximizer
map('n', '<leader>mt', '<cmd>MaximizerToggle<CR>')

-- Packer
map('n', '<leader>ps', '<cmd>PackerSync<CR>')
map('n', '<leader>pu', '<cmd>PackerUpdate<CR>')
map('n', '<leader>pp', '<cmd>PackerProfile<CR>')
map('n', '<leader>pl', ':PackerLoad ')

-- Startup Time
map('n', '<leader>su', '<cmd>StartupTime --tries 20<CR>')

-- Test
map('n', '<leader>tn', '<cmd>TestNearest<CR>')
map('n', '<leader>tf', '<cmd>TestFile<CR>')
map('n', '<leader>ts', '<cmd>TestSuite<CR>')
map('n', '<leader>tl', '<cmd>TestLast<CR>')
map('n', '<leader>tv', '<cmd>TestVisit<CR>')

-- Tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { silent = true })

augroup('auto_format', {
  { 'BufWritePost', '*', 'lua require("plugins.formatter").format_on_save()' },
})
