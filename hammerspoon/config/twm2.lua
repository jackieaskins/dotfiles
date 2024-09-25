local SCREEN_PADDING = CUSTOM.twmScreenPadding or 10
local WINDOW_GAP = CUSTOM.twmWindowGap or 10
local CACHE_KEY_PREFIX = 'twm.cache.'

local wf = hs.window.filter
local windowFilter = require('config.twm.windowFilter')
local hotkeyStore = require('config.hotkeyStore')
local supportedLayouts = require('config.twm.supportedLayouts')

---Get a map from space id to array of windows
---@return table<string, hs.window[]>
local function getWindowsBySpaceId()
  local windowsBySpaceId = {}

  for _, window in ipairs(windowFilter:getWindows()) do
    local spaces = hs.spaces.windowSpaces(window) or {}

    if #spaces == 1 then
      local spaceId = tostring(spaces[1])
      local windows = windowsBySpaceId[spaceId] or {}
      table.insert(windows, window)
      windowsBySpaceId[spaceId] = windows
    else
      Print("not tiling window because it's on multiple spaces", window)
    end
  end

  return windowsBySpaceId
end

---@class (exact) SpaceDetails
---@field screenId string
---@field uuid string

---@class (exact) ScreenLayout
---@field screenIdToSpaceIds table<string, string[]>
---@field spaceIdToScreenId table<string, string>
---@field layouts table<string, string>
---@field windows table<string, hs.window[]>

---@class (exact) CachedScreenLayout
---@field screenIdToSpaceIds table<string, string[]>
---@field spaceIdToScreenId table<string, string>
---@field layouts table<string, string>
---@field windows table<string, string[]>

---Get a stable identifying key for the current screen layout
---@return string
local function getScreenLayoutKey()
  local screenIds = hs.fnutils.imap(hs.screen.allScreens() or {}, function(screen)
    return screen:getUUID()
  end) or {}

  table.sort(screenIds)

  return CACHE_KEY_PREFIX .. table.concat(screenIds, '.')
end

---Get the list of user spaces in Mission Control order
---@return table<string, string[]>
local function getOrderedUserSpaceByScreenId()
  local orderedSpaces = {}

  for _, screen in ipairs(hs.spaces.data_managedDisplaySpaces() or {}) do
    local spaces = {}

    for _, space in ipairs(screen.Spaces) do
      local isUserSpace = space.type == 0
      if isUserSpace then
        table.insert(spaces, tostring(space.ManagedSpaceID))
      end
    end

    orderedSpaces[screen['Display Identifier']] = spaces
  end

  return orderedSpaces
end

---Create a new screen layout based on the current screen configuration
---@return ScreenLayout
local function createScreenLayout()
  local windowsBySpaceId = getWindowsBySpaceId()

  ---@class ScreenLayout
  local screenLayout = {
    screenIdToSpaceIds = {},
    spaceIdToScreenId = {},
    layouts = {},
    windows = {},
  }

  screenLayout.screenIdToSpaceIds = getOrderedUserSpaceByScreenId()
  for screenId, spaceIds in pairs(screenLayout.screenIdToSpaceIds) do
    for _, spaceId in ipairs(spaceIds) do
      screenLayout.spaceIdToScreenId[spaceId] = screenId
      screenLayout.layouts[spaceId] = 'tall'
      screenLayout.windows[spaceId] = windowsBySpaceId[spaceId] or {}
    end
  end

  return screenLayout
end

---Try to load the saved layout for the current screen configuration
---@return ScreenLayout
local function loadScreenLayout()
  ---@type CachedScreenLayout | nil
  local cachedLayout = hs.settings.get(getScreenLayoutKey())
  if not cachedLayout then
    return createScreenLayout()
  end

  -- Add new spaces
  for screenId, spaceIds in pairs(getOrderedUserSpaceByScreenId()) do
    local newSpaceCount = #spaceIds
    local oldSpaceCount = #cachedLayout.screenIdToSpaceIds[screenId]

    while newSpaceCount < oldSpaceCount do
      hs.spaces.addSpaceToScreen(screenId, false)
      newSpaceCount = newSpaceCount + 1
    end
  end
  hs.spaces.closeMissionControl()

  -- Move saved windows to correct spaces
  local firstSpaceId
  local newSpaceIds = {}
  local oldToNewSpaceId = {}
  local newLayouts = {}

  local newSpaceIdsByScreenId = getOrderedUserSpaceByScreenId()
  for screenId, oldSpaceIds in pairs(cachedLayout.screenIdToSpaceIds) do
    local newSpaceIdsForScreen = newSpaceIdsByScreenId[screenId]

    for index, oldSpaceId in ipairs(oldSpaceIds) do
      local newSpaceId = newSpaceIdsForScreen[index]

      if not firstSpaceId then
        firstSpaceId = newSpaceId
      end

      newSpaceIds[newSpaceId] = true
      oldToNewSpaceId[oldSpaceId] = newSpaceId
      newLayouts[newSpaceId] = cachedLayout.layouts[oldSpaceId]
    end
  end

  local oldWindowIdToSpaceId = {}
  for spaceId, windowIds in pairs(cachedLayout.windows) do
    for _, windowId in ipairs(windowIds) do
      oldWindowIdToSpaceId[windowId] = spaceId
    end
  end

  -- TODO: This is broken on MacOS Sequoia :(
  for _, window in ipairs(wf.default:getWindows()) do
    local spaceIds = hs.spaces.windowSpaces(window) or {}

    if #spaceIds == 1 then
      local currentSpaceId = spaceIds[1]
      local oldSpaceId = oldWindowIdToSpaceId[window:id()]
      local newSpaceId = oldSpaceId and oldToNewSpaceId[oldSpaceId] or firstSpaceId

      if tostring(currentSpaceId) ~= newSpaceId then
        hs.spaces.moveWindowToSpace(window, tonumber(newSpaceId))
      end
    end
  end

  -- Remove extra spaces
  for _, spaceIds in pairs(hs.spaces.allSpaces() or {}) do
    for _, spaceId in ipairs(spaceIds) do
      if not newSpaceIds[tostring(spaceId)] then
        hs.spaces.removeSpace(spaceId, false)
      end
    end
  end
  hs.spaces.closeMissionControl()

  local newScreenLayout = createScreenLayout()
  newScreenLayout.layouts = newLayouts
  -- TODO: ensure windows remain in order
  -- TODO: set active screens
  return newScreenLayout
end

local currentScreenLayout = loadScreenLayout()
-- local currentScreenLayout = createScreenLayout()

---Get the frames for the current screens
---@return table<string, ScreenFrame>
local function getScreenFrames()
  local screenFrames = {}
  for _, screen in ipairs(hs.screen.allScreens() or {}) do
    local screenFrame = screen:frame()
    screenFrames[screen:getUUID()] = {
      x = screenFrame.x + SCREEN_PADDING,
      y = screenFrame.y + SCREEN_PADDING,
      w = screenFrame.w - (SCREEN_PADDING * 2),
      h = screenFrame.h - (SCREEN_PADDING * 2),
    }
  end
  return screenFrames
end
local screenFrames = getScreenFrames()

---Save current screen layout to cache
local function saveScreenLayout()
  for spaceId, windows in pairs(currentScreenLayout.windows) do
    currentScreenLayout.windows[spaceId] = hs.fnutils.imap(windows, function(window)
      return window:id()
    end) or {}
  end

  hs.settings.set(getScreenLayoutKey(), currentScreenLayout)
end
hs.shutdownCallback = function()
  saveScreenLayout()
end

---Tile all of the current spaces
local function tile()
  for _, spaceIds in pairs(currentScreenLayout.screenIdToSpaceIds) do
    for _, spaceId in ipairs(spaceIds) do
      local layout = currentScreenLayout.layouts[spaceId]
      local screenId = currentScreenLayout.spaceIdToScreenId[spaceId]
      local screenFrame = screenFrames[screenId]
      local windows = currentScreenLayout.windows[spaceId] or {}

      if #windows == 1 then
        supportedLayouts.monocle(windows, screenFrame, WINDOW_GAP)
      elseif #windows > 1 then
        supportedLayouts[layout](windows, screenFrame, WINDOW_GAP)
      end
    end
  end
end
tile()

local function retileWindows()
  local currentWindowsBySpaceId = currentScreenLayout.windows
  local windowsBySpaceId = getWindowsBySpaceId()

  for spaceId, spaceWindows in pairs(windowsBySpaceId) do
    local currentSpaceWindows = currentWindowsBySpaceId[spaceId] or {}

    table.sort(spaceWindows, function(a, b)
      local aIndex = hs.fnutils.indexOf(currentSpaceWindows, a)
      local bIndex = hs.fnutils.indexOf(currentSpaceWindows, b)

      -- Unstable sort fn was being returned when object compared against itself
      if aIndex == bIndex then
        return false
      end

      return (aIndex and bIndex) and (aIndex < bIndex) or not bIndex
    end)
  end

  currentScreenLayout.windows = windowsBySpaceId

  tile()
end
local retileWindowEvents = {
  wf.windowsChanged,
  wf.windowMoved,
  wf.windowAllowed,
  wf.windowRejected,
}
windowFilter:subscribe(retileWindowEvents, retileWindows)

wf.defaultCurrentSpace:subscribe({ wf.windowDestroyed }, function()
  local focusedWindow = hs.window.focusedWindow()

  if not focusedWindow or not focusedWindow:isVisible() then
    local windows = wf.defaultCurrentSpace:getWindows()
    if #windows >= 1 then
      windows[1]:focus()
    end
  end
end)

local twmRegister = hotkeyStore.registerGroup('twm')

twmRegister('tile', MEH, 't', tile)

---Set the layout for the provided spaceId and retile
---@param spaceId string
---@param layout string
local function setSpaceLayout(spaceId, layout)
  currentScreenLayout.layouts[spaceId] = layout
  tile()
  hs.alert.show(layout)
end
twmRegister('toggle between monocle and tall', MEH, 's', function()
  local spaceId = tostring(hs.spaces.focusedSpace())
  local currentLayout = currentScreenLayout.layouts[spaceId]
  setSpaceLayout(spaceId, currentLayout == 'tall' and 'monocle' or 'tall')
end)

twmRegister('focus window west', MEH, 'h', wf.focusWest)
twmRegister('focus window south', MEH, 'j', wf.focusSouth)
twmRegister('focus window north', MEH, 'k', wf.focusNorth)
twmRegister('focus window east', MEH, 'l', wf.focusEast)

---Swap focused window with window in direction
---@param direction 'west' | 'south' | 'north' | 'east'
---@return fun()
local function swapWindow(direction)
  local windowsTo = {
    west = 'windowsToWest',
    south = 'windowsToSouth',
    north = 'windowsToNorth',
    east = 'windowsToEast',
  }

  local windowsToFn = windowFilter[windowsTo[direction]]

  return function()
    local focusedWindow = hs.window.focusedWindow()
    local windows = windowsToFn(windowFilter, focusedWindow, true, false)
    local currentSpaceId = tostring(hs.spaces.focusedSpace())

    if #windows >= 1 then
      local windowToSwap = windows[1]

      local spaceWindows = currentScreenLayout.windows[currentSpaceId]
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
twmRegister('swap window west', HYPER, 'h', swapWindow('west'))
twmRegister('swap window south', HYPER, 'j', swapWindow('south'))
twmRegister('swap window north', HYPER, 'k', swapWindow('north'))
twmRegister('swap window east', HYPER, 'l', swapWindow('east'))

twmRegister('maximize window', HYPER, 'm', function()
  local focusedWindow = hs.window.focusedWindow()
  if not windowFilter:isWindowAllowed(focusedWindow) then
    local screenId = hs.screen.mainScreen():getUUID()
    supportedLayouts.monocle({ focusedWindow }, screenFrames[screenId], WINDOW_GAP)
  end
end)
