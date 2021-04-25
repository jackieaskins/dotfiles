local utils = require('utils')
local map = utils.map
local fn = vim.fn

-- Window Management
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Navigate Quickfix
map('n', ']q', ':cnext<CR>')
map('n', '[q', ':cprevious<CR>')

map('n', 'gx', '<cmd>call v:lua.OpenURLUnderCursor()<CR>')
function _G.OpenURLUnderCursor()
  local uri = fn.substitute(fn.expand('<cWORD>'), '?', '\\?', '')
  local pairs = {
    {'"', '"'},
    {"'", "'"},
    {'(', ')'},
    {'[', ']'},
    {'{', '}'},
    {'*', '*'},
  }

  local function is_surrounded()
    local matches = vim.tbl_filter(function (pair)
      return vim.startswith(uri, pair[1]) and vim.endswith(uri, pair[2])
    end, pairs)

    return not vim.tbl_isempty(matches)
  end

  while is_surrounded() do
    uri = string.sub(uri, 2, -2)
  end

  uri = fn.shellescape(uri)

  if uri ~= '' then
    vim.cmd('!open ' .. uri)
    vim.cmd 'redraw!'
  end
end
