local ScreenManager = require('twm.ScreenManager')
local hotkeyStore = require('hotkeyStore')

local wf = hs.window.filter

screenManager = ScreenManager.new():start()

local twmRegister = hotkeyStore.registerGroup('Window Management')

twmRegister('Tile', MEH, 't', function()
  screenManager.windowManager:tile()
end)

twmRegister('Toggle between stack and tall', MEH, 's', function()
  screenManager.windowManager:toggleStackLayout(hs.spaces.focusedSpace())
end)

twmRegister('Focus window west', MEH, 'h', wf.focusWest)
twmRegister('Focus window south', MEH, 'j', wf.focusSouth)
twmRegister('Focus window north', MEH, 'k', wf.focusNorth)
twmRegister('Focus window east', MEH, 'l', wf.focusEast)

twmRegister('Swap window west', HYPER, 'h', function()
  screenManager.windowManager:swapWindowWest()
end)
twmRegister('Swap window south', HYPER, 'j', function()
  screenManager.windowManager:swapWindowSouth()
end)
twmRegister('Swap window north', HYPER, 'k', function()
  screenManager.windowManager:swapWindowNorth()
end)
twmRegister('Swap window east', HYPER, 'l', function()
  screenManager.windowManager:swapWindowEast()
end)

twmRegister('Reset tiling', HYPER, 'r', function()
  screenManager:stop()
  screenManager = ScreenManager.new():start()
end)

for spaceId = 1, 9 do
  twmRegister('Move window to space ' .. spaceId, MEH, tostring(spaceId), function()
    hs.spaces.moveWindowToSpace(hs.window.focusedWindow(), spaceId)
  end)
end

for screenIndex = 1, 9 do
  twmRegister('Move window to screen ' .. screenIndex, HYPER, tostring(screenIndex), function()
    local screens = hs.screen.allScreens() or {}
    hs.window.focusedWindow():moveToScreen(screens[screenIndex])
  end)
end

twmRegister('Focus screen west', MEH, 'left', function()
  hs.screen.find(hs.spaces.spaceDisplay(hs.spaces.focusedSpace())):toWest()
end)
twmRegister('Focus screen south', MEH, 'down', function()
  hs.screen.find(hs.spaces.spaceDisplay(hs.spaces.focusedSpace())):toSouth()
end)
twmRegister('Focus screen north', MEH, 'up', function()
  hs.screen.find(hs.spaces.spaceDisplay(hs.spaces.focusedSpace())):toNorth()
end)
twmRegister('Focus screen east', MEH, 'right', function()
  hs.screen.find(hs.spaces.spaceDisplay(hs.spaces.focusedSpace())):toEast()
end)
