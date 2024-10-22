local SCREEN_PADDING = CUSTOM.twmScreenPadding or 10

local fnutils = require('fnutils')
local cache = require('twm.cache')

---@class (exact) ScreenLayout
---@field key string
---@field screenIdToSpaceIds table<string, number[]>
---@field screenIdToFrame table<string, ScreenFrame>
---@field spaceIdToLayout table<integer, string>
---@field spaceIdToWindows table<integer, hs.window[]>

local wf = hs.window.filter
local windowFilter = require('twm.windowFilter')

---Get a map from space id to array of windows
---@return table<integer, hs.window[]>
local function getWindowsBySpaceId()
  ---@type table<integer, hs.window[]>
  local windowsBySpaceId = {}

  for _, window in ipairs(windowFilter:getWindows()) do
    local windowSpaces = hs.spaces.windowSpaces(window) or {}
    -- We are assuming the window is only on one space because of how the window filter is configured
    local spaceId = windowSpaces[1]

    local windows = windowsBySpaceId[spaceId] or {}
    table.insert(windows, window)
    windowsBySpaceId[spaceId] = windows
  end

  return windowsBySpaceId
end

---Get the list of user spaces in Mission Control order
---@return table<string, integer[]>
local function getOrderedUserSpacesByScreenId()
  local spacesByScreenId = {}

  for _, display in ipairs(hs.spaces.data_managedDisplaySpaces() or {}) do
    spacesByScreenId[display['Display Identifier']] = fnutils.ireduce(display.Spaces, function(space, spaceIds)
      if space.type == 0 then
        table.insert(spaceIds, space.ManagedSpaceID)
      end
      return spaceIds
    end, {})
  end

  return spacesByScreenId
end

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

---Sort the windows on all spaces
---@param oldWindowsBySpaceId table<number, hs.window[]>
---@param newWindowsBySpaceId table<number, hs.window[]>
local function sortWindows(oldWindowsBySpaceId, newWindowsBySpaceId)
  for spaceId, spaceWindows in pairs(newWindowsBySpaceId) do
    local currentSpaceWindows = oldWindowsBySpaceId[spaceId] or {}

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
end

---Create a new screen layout based on the current screen configuration
---@return ScreenLayout
local function createLayout()
  local windowsBySpaceId = getWindowsBySpaceId()

  ---@type ScreenLayout
  local screenLayout = {
    key = cache.getScreenLayoutKey(),
    screenIdToSpaceIds = {},
    screenIdToFrame = getScreenFrames(),
    spaceIdToLayout = {},
    spaceIdToWindows = {},
  }

  screenLayout.screenIdToSpaceIds = getOrderedUserSpacesByScreenId()
  for _, spaceIds in pairs(screenLayout.screenIdToSpaceIds) do
    for _, spaceId in ipairs(spaceIds) do
      screenLayout.spaceIdToLayout[spaceId] = 'tall'
      screenLayout.spaceIdToWindows[spaceId] = windowsBySpaceId[spaceId] or {}
    end
  end

  return screenLayout
end

---@type ScreenLayout
local currentScreenLayout

local M = {}

---Try to load the saved layout for the current screen configuration
function M.createOrLoad()
  local cachedLayout = cache.loadLayout()
  if not cachedLayout then
    currentScreenLayout = createLayout()
    return
  end

  hs.alert.show('Loading saved screen layout')

  -- Add new spaces
  for screenId, spaceIds in pairs(getOrderedUserSpacesByScreenId()) do
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

  local newSpaceIdsByScreenId = getOrderedUserSpacesByScreenId()
  for screenId, oldSpaceIds in pairs(cachedLayout.screenIdToSpaceIds) do
    local newSpaceIdsForScreen = newSpaceIdsByScreenId[screenId]

    for index, oldSpaceId in ipairs(oldSpaceIds) do
      local newSpaceId = newSpaceIdsForScreen[index]

      if not firstSpaceId then
        firstSpaceId = newSpaceId
      end

      newSpaceIds[newSpaceId] = true
      oldToNewSpaceId[oldSpaceId] = newSpaceId
      newLayouts[newSpaceId] = cachedLayout.spaceIdToLayout[oldSpaceId]
    end
  end

  local oldWindowIdToSpaceId = {}
  for spaceId, windows in pairs(cachedLayout.spaceIdToWindows) do
    for _, window in ipairs(windows) do
      oldWindowIdToSpaceId[window:id()] = spaceId
    end
  end

  -- TODO: This is broken on MacOS Sequoia :(
  for _, window in ipairs(wf.default:getWindows()) do
    local spaceIds = hs.spaces.windowSpaces(window) or {}

    if #spaceIds == 1 and not window:isFullScreen() then
      local currentSpaceId = spaceIds[1]
      local oldSpaceId = oldWindowIdToSpaceId[window:id()]
      local newSpaceId = oldSpaceId and oldToNewSpaceId[oldSpaceId] or firstSpaceId

      if currentSpaceId ~= newSpaceId then
        hs.spaces.moveWindowToSpace(window, newSpaceId)
      end
    end
  end

  -- Remove extra spaces
  for _, spaceIds in pairs(hs.spaces.allSpaces() or {}) do
    for _, spaceId in ipairs(spaceIds) do
      if not newSpaceIds[spaceId] and hs.spaces.spaceType(spaceId) == 'user' then
        hs.spaces.removeSpace(spaceId, false)
      end
    end
  end
  hs.spaces.closeMissionControl()

  local newScreenLayout = createLayout()
  newScreenLayout.spaceIdToLayout = newLayouts
  sortWindows(cachedLayout.spaceIdToWindows, newScreenLayout.spaceIdToWindows)
  currentScreenLayout = newScreenLayout
end

---Recalculate the current screen layout windows
function M.recalculateWindows()
  local spaceIdToWindows = getWindowsBySpaceId()
  sortWindows(currentScreenLayout.spaceIdToWindows, spaceIdToWindows)
  currentScreenLayout.spaceIdToWindows = spaceIdToWindows
end

---Save current layout to cache
function M.save()
  cache.saveLayout(currentScreenLayout)
end

function M.reset()
  currentScreenLayout = createLayout()
end

function M.getKey()
  return currentScreenLayout.key
end

---Get a map from screen id to space id
---@return table<string, number[]>
function M.getScreenIdToSpaceIdsMap()
  return currentScreenLayout.screenIdToSpaceIds
end

---Get a map from space id to layout string
---@return table<integer, string>
function M.getSpaceIdToLayoutMap()
  return currentScreenLayout.spaceIdToLayout
end

---Get a map from screen id to frame
---@return table<string, ScreenFrame>
function M.getScreenIdToFrameMap()
  return currentScreenLayout.screenIdToFrame
end

---Get a map from space id to windows
---@return table<integer, hs.window[]>
function M.getSpaceIdToWindowsMap()
  return currentScreenLayout.spaceIdToWindows
end

M.createOrLoad()
hs.shutdownCallback = function()
  M.save()
end

return M
