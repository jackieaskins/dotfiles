-- Map Leader to Space
vim.g.mapleader = ' '
require('utils').map({ 'n', 'v' }, '<space>', '<nop>')

require('config_variables')
require('options')

if require('utils').file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('lazy_config')

require('autocmds')
require('keymaps')
require('user_commands')

require('lsp')
require('diagnostic')
