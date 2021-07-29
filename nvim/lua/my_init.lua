local file_exists = require'my_utils'.file_exists

require 'my_settings'
require 'my_keymappings'
if file_exists('~/dotfiles/nvim/lua/my_custom.lua') then require 'my_custom' end
require 'my_plugins'
require 'my_plugins/colorscheme'
