local TilingWindowManager = require('twm.TilingWindowManager')

twm = TilingWindowManager.new()
require('twm.menubar')

screenWatcher = hs.screen.watcher
  .new(function()
    twm:destroy()
    twm = TilingWindowManager.new()
  end)
  :start()

local twmRegister = require('hotkeyStore').registerGroup('Window Management')

twmRegister('Toggle between Stack and Tall', MEH, 's', function()
  twm:toggleWorkspaceLayout()
end)

twmRegister('Tile', MEH, 't', function()
  twm:tile()
end)

twmRegister('Reset window manager', HYPER, 't', function()
  twm:destroy()
  twm = TilingWindowManager.new()
end)

local directionMap = { h = 'West', j = 'South', k = 'North', l = 'East' }

for key, direction in pairs(directionMap) do
  twmRegister('Focus window to ' .. direction, MEH, key, function()
    twm:focusWindowInDirection(direction)
  end)
end

for key, direction in pairs(directionMap) do
  twmRegister('Swap window to ' .. direction, HYPER, key, function()
    twm:swapWindowInDirection(direction)
  end)
end

for index = 1, 9 do
  twmRegister('Focus space ' .. index, { 'ctrl', 'shift' }, tostring(index), function()
    twm:focusWorkspace(index)
  end)
end

for index = 1, 9 do
  twmRegister('Move focused window to space ' .. index, MEH, tostring(index), function()
    twm:moveFocusedWindowToWorkspace(index)
  end)
end

for index = 1, 9 do
  twmRegister('Move focused window to screen ' .. index, HYPER, tostring(index), function()
    twm:moveFocusedWindowToScreen(index)
  end)
end
