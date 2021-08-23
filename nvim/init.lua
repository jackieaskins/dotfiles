local file_exists = require('utils').file_exists

require('settings')
require('keymappings')
require('closer')

if file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('plugins')
require('lsp')
require('colorscheme')
