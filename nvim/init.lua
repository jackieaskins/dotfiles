pcall(require, 'impatient')

require('globals')

require('settings')
require('autocmds')
require('keymaps')
require('user_commands')

if require('utils').file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('plugins')
require('lsp')
require('diagnostic')
require('colorscheme')
