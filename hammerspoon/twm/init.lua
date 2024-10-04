local WINDOW_GAP = CUSTOM.twmWindowGap or 10

local wf = hs.window.filter
local windowFilter = require('twm.windowFilter')
local hotkeyStore = require('hotkeyStore')
local supportedLayouts = require('twm.supportedLayouts')

local screenLayout = require('twm.screenLayout')

-- TODO: Detect space changes
-- TODO: Add menubar icon

---Tile all of the current spaces
local function tile()
  for screenId, spaceIds in pairs(screenLayout.getScreenIdToSpaceIdsMap()) do
    for _, spaceId in ipairs(spaceIds) do
      local layout = screenLayout.getSpaceIdToLayoutMap()[spaceId]
      local screenFrame = screenLayout.getScreenIdToFrameMap()[screenId]
      local windows = screenLayout.getSpaceIdToWindowsMap()[spaceId] or {}

      if #windows == 1 then
        supportedLayouts.monocle(windows, screenFrame, WINDOW_GAP)
      elseif #windows > 1 then
        supportedLayouts[layout](windows, screenFrame, WINDOW_GAP)
      end
    end
  end
end
tile()

windowFilter:subscribe({
  wf.windowsChanged,
  wf.windowMoved,
  wf.windowAllowed,
  wf.windowRejected,
  wf.windowNotInCurrentSpace,
  wf.windowInCurrentSpace,
}, function()
  screenLayout.recalculateWindows()
  tile()
end)

wf.defaultCurrentSpace:subscribe({ wf.windowDestroyed }, function()
  local focusedWindow = hs.window.focusedWindow()

  if not focusedWindow or not focusedWindow:isVisible() then
    local windows = wf.defaultCurrentSpace:getWindows()
    if #windows >= 1 then
      windows[1]:focus()
    end
  end
end)

screenWatcher = hs.screen.watcher.new(function()
  if screenLayout.getKey() == require('twm.cache').getScreenLayoutKey() then
    return
  end

  windowFilter:pause()

  screenLayout.save()
  screenLayout.createOrLoad()
  tile()

  windowFilter:resume()
end)
screenWatcher:start()

local twmRegister = hotkeyStore.registerGroup('twm')

twmRegister('tile', MEH, 't', tile)

---Set the layout for the provided spaceId and retile
---@param spaceId number
---@param layout string
local function setSpaceLayout(spaceId, layout)
  screenLayout.getSpaceIdToLayoutMap()[spaceId] = layout
  tile()
  hs.alert.show(layout)
end
twmRegister('toggle between monocle and tall', MEH, 's', function()
  local spaceId = hs.spaces.focusedSpace()
  local currentLayout = screenLayout.getSpaceIdToLayoutMap()[spaceId]
  setSpaceLayout(spaceId, currentLayout == 'tall' and 'monocle' or 'tall')
end)

twmRegister('focus window west', MEH, 'h', wf.focusWest)
twmRegister('focus window south', MEH, 'j', wf.focusSouth)
twmRegister('focus window north', MEH, 'k', wf.focusNorth)
twmRegister('focus window east', MEH, 'l', wf.focusEast)

---Swap focused window with window in direction
---@param direction 'West' | 'South' | 'North' | 'East'
---@return fun()
local function swapWindow(direction)
  local windowsToFn = windowFilter['windowsTo' .. direction]

  return function()
    local focusedWindow = hs.window.focusedWindow()
    local windows = windowsToFn(windowFilter, focusedWindow, true, false)
    local currentSpaceId = hs.spaces.focusedSpace()

    if #windows >= 1 then
      local windowToSwap = windows[1]

      local spaceWindows = screenLayout.getSpaceIdToWindowsMap()[currentSpaceId]
      local currentIndex = hs.fnutils.indexOf(spaceWindows, focusedWindow)
      local newIndex = hs.fnutils.indexOf(spaceWindows, windowToSwap)

      if currentIndex and newIndex then
        spaceWindows[currentIndex] = windowToSwap
        spaceWindows[newIndex] = focusedWindow
      end

      tile()
    end
  end
end
twmRegister('swap window west', HYPER, 'h', swapWindow('West'))
twmRegister('swap window south', HYPER, 'j', swapWindow('South'))
twmRegister('swap window north', HYPER, 'k', swapWindow('North'))
twmRegister('swap window east', HYPER, 'l', swapWindow('East'))

twmRegister('maximize window', HYPER, 'm', function()
  local focusedWindow = hs.window.focusedWindow()
  if not windowFilter:isWindowAllowed(focusedWindow) then
    local screenId = hs.screen.mainScreen():getUUID()
    supportedLayouts.monocle({ focusedWindow }, screenLayout.getScreenIdToFrameMap()[screenId], WINDOW_GAP)
  end
end)

twmRegister('reset tiling', HYPER, 'r', function()
  screenLayout.reset()
  tile()
end)
