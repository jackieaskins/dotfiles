local fn = vim.fn
local cmd = vim.cmd

require'my_settings'
require'my_keymappings'

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  require'my_plugins'
  cmd 'PackerSync'
else
  cmd 'autocmd BufWritePost */my_plugins.lua PackerCompile'
  require'my_plugins'
end

require'my_plugins/colorscheme'
