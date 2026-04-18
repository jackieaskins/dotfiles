local wezterm = require('wezterm')
local workspaces = require('workspaces')

local act = wezterm.action

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
    action = act.DisableDefaultAssignment,
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
  {
    key = 'n',
    mods = 'CMD|SHIFT',
    action = act.PromptInputLine({
      description = 'Enter workspace name',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
        end
      end),
    }),
  },

  -- Navigator
  {
    key = 'h',
    mods = 'CTRL',
    action = focus_window('CTRL', 'h', 'Left'),
  },
  {
    key = 'j',
    mods = 'CTRL',
    action = focus_window('CTRL', 'j', 'Down'),
  },
  {
    key = 'k',
    mods = 'CTRL',
    action = focus_window('CTRL', 'k', 'Up'),
  },
  {
    key = 'l',
    mods = 'CTRL',
    action = focus_window('CTRL', 'l', 'Right'),
  },

  {
    key = '_',
    mods = 'CMD',
    action = act.SplitVertical,
  },
  {
    key = '|',
    mods = 'CMD',
    action = act.SplitHorizontal,
  },

  {
    key = ',',
    mods = 'CMD',
    action = act.PromptInputLine({
      description = 'Enter tab title',
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}
