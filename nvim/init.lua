-- Map Leader to Space
vim.g.mapleader = ' '
require('utils').map({ 'n', 'v' }, '<space>', '<nop>')

require('config_variables')
require('options')

require('dark_mode')

if require('utils').file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

if MY_CONFIG.experimental_ui then
  require('vim._extui').enable({
    msg = { target = 'msg' },
  })
end

require('lazy_config')

require('autocmds')
require('keymaps')
require('user_commands')

require('diagnostic')
