-- Map Leader to Space
vim.g.mapleader = ' '
require('utils').map({ 'n', 'v' }, '<space>', '<nop>')

require('config_variables')
require('options')
require('folds')

require('dark_mode')

if require('utils').file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('vim._core.ui2').enable({
  msg = { target = 'msg' },
})

require('lazy_config')

require('autocmds')
require('keymaps')
require('user_commands')

require('diagnostic')
