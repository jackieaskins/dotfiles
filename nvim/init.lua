local file_exists = require('utils').file_exists

pcall(require, 'impatient')

require('settings')
require('keymappings')

if file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('plugins')
require('lsp')
require('colorscheme')
