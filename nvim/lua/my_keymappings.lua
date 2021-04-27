local utils = require('my_utils')
local map = utils.map
local fn = vim.fn
local cmd = vim.cmd

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

map('n', 'gx', '<cmd>call v:lua.OpenURLUnderCursor()<CR>')
map('n', '<leader>re', '<cmd>call v:lua.ReloadConfig()<CR>')
map('n', '<leader>rp', '<cmd>call v:lua.ReloadPlugins()<CR>')

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
    cmd('!open ' .. uri)
    cmd 'redraw!'
  end
end

local function reload()
  require'plenary.reload'.reload_module('my_', true)
  require'my_init'
end

function _G.ReloadConfig()
  reload()
  cmd 'LspRestart'
end

function _G.ReloadPlugins()
  cmd 'LspStop'
  reload()
  cmd 'PackerSync'
  cmd 'LspStart'
end
