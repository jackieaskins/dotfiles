local wezterm = require('wezterm')
local act = wezterm.action

return function(mod_key, vim_direction, pane_direction)
  return wezterm.action_callback(function(window, pane)
    local is_vi_process = pane:get_foreground_process_name():find('n?vim') ~= nil

    if is_vi_process then
      window:perform_action(act.SendKey({ key = vim_direction, mods = mod_key }), pane)
    else
      window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
  end)
end
