pcall(require, 'impatient')

require('globals')

require('settings')
require('keymappings')
require('user_commands')

if require('utils').file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('closer')

require('plugins')
require('lsp')
require('colorscheme')
