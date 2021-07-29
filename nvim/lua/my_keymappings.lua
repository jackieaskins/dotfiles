local utils = require('my_utils')
local augroup = utils.augroup
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

map('n', '<leader>gh', "yi':!open https://github.com/<C-R>0<CR><CR>")
map('n', '<leader>ob', '<cmd>call v:lua.OpenHomebrewURL()<CR>')
augroup('packer_links', {
  {'FileType', 'packer', 'nnoremap <buffer> <leader>gh <cmd>call v:lua.OpenPackerURL()<CR>'},
})

local function open_url(url) os.execute('open ' .. url) end

function _G.OpenHomebrewURL()
  local current_line = vim.fn.getline('.')
  local package = string.match(current_line, "'.-'")
  package = string.sub(package, 2, -2)

  if vim.startswith(current_line, 'brew') then
    open_url('https://formulae.brew.sh/formula/' .. package .. '#default')
  elseif vim.startswith(current_line, 'cask') then
    open_url('https://formulae.brew.sh/cask/' .. package .. '#default')
  end
end

function _G.OpenPackerURL()
  local user_package = fn.expand('<cWORD>')
  user_package = string.sub(user_package, 1, -2) -- Remove trailing ':'
  open_url('https://github.com/' .. user_package)
end

function _G.OpenURLUnderCursor()
  local uri = fn.substitute(fn.expand('<cWORD>'), '?', '\\?', '')
  local pairs = {{'"', '"'}, {"'", "'"}, {'(', ')'}, {'[', ']'}, {'{', '}'}, {'*', '*'}}

  local function is_surrounded()
    local matches = vim.tbl_filter(function(pair)
      return vim.startswith(uri, pair[1]) and vim.endswith(uri, pair[2])
    end, pairs)

    return not vim.tbl_isempty(matches)
  end

  while is_surrounded() do
    uri = string.sub(uri, 2, -2) -- Remove surrounding chracters
  end

  uri = fn.shellescape(uri)
  if uri ~= '' then open_url(uri) end
end

local function reload()
  require'plenary.reload'.reload_module('my_', true)
  require 'my_init'
end

function _G.ReloadConfig()
  reload()
  cmd 'LspRestart'
end

function _G.ReloadPlugins()
  augroup('reload_plugins', {{'User', 'PackerComplete', '++once', 'LspStart'}})
  cmd 'LspStop'
  reload()
  cmd 'PackerSync'
end
