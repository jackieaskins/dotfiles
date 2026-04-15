local wezterm = require('wezterm')
local workspaces = require('workspaces')

local act = wezterm.action

local navigate_mod = 'CTRL'

local function focus_window(mod_key, vim_direction, pane_direction)
  return wezterm.action_callback(function(window, pane)
    local process = pane:get_foreground_process_name()

    local is_vi_process = process:find('n?vim') ~= nil
    local is_tmux = process:find('tmux') ~= nil

    if is_vi_process or is_tmux then
      window:perform_action(act.SendKey({ key = vim_direction, mods = mod_key }), pane)
    else
      window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
  end)
end

return {
  -- Used for tmux suspend
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },

  -- General
  {
    key = 'k',
    mods = 'CMD',
    action = act.Multiple({
      act.ClearScrollback('ScrollbackAndViewport'),
      act.SendKey({ key = 'l', mods = 'CTRL' }),
    }),
  },

  -- Workspaces
  {
    key = 's',
    mods = 'CMD',
    action = workspaces.open_switcher(),
  },

  -- Navigator
  {
    key = 'h',
    mods = navigate_mod,
    action = focus_window(navigate_mod, 'h', 'Left'),
  },
  {
    key = 'j',
    mods = navigate_mod,
    action = focus_window(navigate_mod, 'j', 'Down'),
  },
  {
    key = 'k',
    mods = navigate_mod,
    action = focus_window(navigate_mod, 'k', 'Up'),
  },
  {
    key = 'l',
    mods = navigate_mod,
    action = focus_window(navigate_mod, 'l', 'Right'),
  },
}
