local wezterm = require('wezterm')
local act = wezterm.action

local function clear_handler(window, pane)
  window:perform_action(act.ClearScrollback('ScrollbackAndViewport'), pane)
end

local function interrupt_handler(window, pane)
  window:perform_action(act.SendKey({ key = 'c', mods = 'CTRL' }), pane)
end

local nvim_events = {
  ['nvim-clear'] = clear_handler,
  ['nvim-interrupt'] = interrupt_handler,
}

wezterm.on('user-var-changed', function(window, _pane, name, value)
  local handler = nvim_events[name]

  if not handler then
    return
  end

  local pane_id = value
  local pane = wezterm.mux.get_pane(pane_id)

  handler(window, pane)
end)
