local file_exists = require('utils').file_exists

local lua_version = string.gsub(_VERSION, 'Lua ', '')
local jit_version = string.gsub(jit.version, 'LuaJIT ', '')
local packer_install_path = table.concat({
  '~/.cache/nvim/packer_hererocks/',
  jit_version,
  '/lib/lua/',
  lua_version,
  '/?.so',
}, '')

package.cpath = package.cpath .. ';' .. vim.fn.expand(packer_install_path)
pcall(require, 'impatient')

require('settings')
require('keymappings')
require('closer')

if file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('plugins')
require('lsp')
require('colorscheme')
