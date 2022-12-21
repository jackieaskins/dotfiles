require('globals')
require('settings')

if require('utils').file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('lazy_config')

require('autocmds')
require('keymaps')
require('user_commands')

require('lsp')
require('diagnostic')
