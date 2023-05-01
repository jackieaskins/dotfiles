local wezterm = require('wezterm')
local act = wezterm.action

return function(mod_key, vim_direction, pane_direction)
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
