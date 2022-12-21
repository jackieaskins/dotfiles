local utils = require('utils')
local map = utils.map

-- Diagnostics
map('n', 'g?', '<cmd>lua vim.diagnostic.open_float(0, { scope = "cursor" })<CR>')
map('n', '[g', vim.diagnostic.goto_prev, { desc = 'vim.diagnostic.goto_prev' })
map('n', ']g', vim.diagnostic.goto_next, { desc = 'vim.diagnostic.goto_next' })
map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>')
map('n', ']e', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>')

-- Extended gx
map('n', 'gx', function()
  require('gx').handle_url_under_cursor()
end, { desc = 'Open url under cursor' })

-- Yank to System Clipboard
local yank_keys = { 'd', 'y', 'c' }
for _, key in ipairs(yank_keys) do
  map({ 'n', 'v' }, '<leader>' .. key, '"+' .. key)
end

-- Jumplist
local function jump(key)
  return function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. key or key
  end
end
map('n', 'k', jump('k'), { desc = 'Jump [count] lines up', expr = true })
map('n', 'j', jump('j'), { desc = 'Jump [count] lines down', expr = true })

-- Navigate Quickfix
map('n', '[q', vim.cmd.cprevious)
map('n', ']q', vim.cmd.cnext)
map('n', '[Q', vim.cmd.cfirst)
map('n', ']Q', vim.cmd.clast)
map('n', '[<C-q>', vim.cmd.cpfile)
map('n', ']<C-q>', vim.cmd.cnfile)

-- Navigate Location List
map('n', '[l', vim.cmd.lprevious)
map('n', ']l', vim.cmd.lnext)
map('n', '[L', vim.cmd.lfirst)
map('n', ']L', vim.cmd.llast)
map('n', '[<C-l>', vim.cmd.lpfile)
map('n', ']<C-l>', vim.cmd.lnfile)

-- Navigate Files
map('n', '[n', vim.cmd.previous)
map('n', ']n', vim.cmd.next)
map('n', '[N', vim.cmd.first)
map('n', ']N', vim.cmd.last)

map('n', '<leader>so', '<cmd>luafile %<CR>')

-- Lazy
map('n', '<leader>lc', '<cmd>Lazy check<CR>')
map('n', '<leader>li', '<cmd>Lazy install<CR>')
map('n', '<leader>ll', '<cmd>Lazy show<CR>')
map('n', '<leader>lp', '<cmd>Lazy profile<CR>')
map('n', '<leader>ls', '<cmd>Lazy sync<CR>')
map('n', '<leader>lu', '<cmd>Lazy update<CR>')
map('n', '<leader>lx', '<cmd>Lazy clean<CR>')
