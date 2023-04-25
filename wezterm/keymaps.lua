local wezterm = require('wezterm')
local act = wezterm.action

local focus_window = require('actions.focus_window')
local manage_workspaces = require('actions.manage_workspaces')

local FOCUS_MOD = 'CTRL'

return {
  { key = 'h', mods = FOCUS_MOD, action = focus_window(FOCUS_MOD, 'h', 'Left') },
  { key = 'j', mods = FOCUS_MOD, action = focus_window(FOCUS_MOD, 'j', 'Down') },
  { key = 'k', mods = FOCUS_MOD, action = focus_window(FOCUS_MOD, 'k', 'Up') },
  { key = 'l', mods = FOCUS_MOD, action = focus_window(FOCUS_MOD, 'l', 'Right') },

  { key = 'k', mods = 'CMD', action = act.ClearScrollback('ScrollbackAndViewport') },
  { key = 'p', mods = 'CMD', action = act.ActivateCommandPalette },

  { key = 'w', mods = 'CMD', action = act.CloseCurrentPane({ confirm = true }) },
  { key = '_', mods = 'CMD', action = act.SplitVertical },
  { key = '|', mods = 'CMD', action = act.SplitHorizontal },

  { key = 's', mods = 'CMD', action = manage_workspaces },
}
