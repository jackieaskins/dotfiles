-- Load custom file if it exists
local custom_exists, custom = pcall(require, 'custom')
CUSTOM = custom_exists and custom or {} -- Makes custom variables global

local wezterm = require('wezterm')

local config = {}

config.term = 'wezterm'
config.leader = { key = 'a', mods = 'CTRL' }
require('nvim_user_vars')

-- Keys
config.keys = require('keymaps')

-- Color Scheme
config.color_schemes = { CatppuccinCustom = require('color_scheme') }
config.color_scheme = 'CatppuccinCustom'

-- Font
config.font = wezterm.font({
  family = 'JetBrainsMono Nerd Font',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures
})

-- Tab Bar
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 75
require('tab_format')
require('status')

-- Window
config.window_decorations = 'RESIZE'
config.window_padding = { left = 0, right = 0, top = '1cell', bottom = 0 }

return config
