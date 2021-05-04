local file_exists = require'my_utils'.file_exists
local fn = vim.fn
local cmd = vim.cmd

require'my_settings'
require'my_keymappings'

if file_exists('~/dotfiles/lua/my_custom.lua') then
  require'my_custom'
end

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if file_exists(install_path) then
  cmd 'autocmd BufWritePost */my_plugins.lua PackerCompile'
  require'my_plugins'
else
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  require'my_plugins'
  cmd 'PackerSync'
end

require'my_plugins/colorscheme'
