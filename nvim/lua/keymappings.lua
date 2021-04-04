local utils = require('utils')
local map = utils.map
local fn = vim.fn

-- Window Management
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

map('n', ']q', ':cnext')
map('n', '[q', ':cprevious')

function _G.OpenURLUnderCursor()
  local uri = fn.shellescape(
    fn.substitute(fn.expand('<cWORD>'), '?', '\\?', ''), 1
  )
  if uri ~= '' then
    vim.cmd('!open ' .. uri)
    vim.cmd 'redraw!'
  end
end
map('n', 'gx', '<cmd>call v:lua.OpenURLUnderCursor()<CR>')
