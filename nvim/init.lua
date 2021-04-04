local fn = vim.fn
local cmd = vim.cmd

require'settings'
require'keymappings'

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  require'plugins'
  cmd'PackerSync'
else
  cmd 'autocmd BufWritePost plugins.lua PackerCompile'
  require'plugins'
end

