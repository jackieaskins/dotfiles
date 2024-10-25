local fnutils = require('fnutils')

---@class (exact) ScreenLayout
---@field screenIdToSpaceIds table<string, number[]>
---@field spaceIdToLayout table<integer, string>
---@field spaceIdToWindows table<integer, hs.window[]>

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

---@type ScreenLayout
local currentScreenLayout

local M = {}

---Create a new screen layout based on the current screen configuration
function M.create()
  local windowsBySpaceId = getWindowsBySpaceId()

  ---@type ScreenLayout
  local screenLayout = {
    screenIdToSpaceIds = {},
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

  currentScreenLayout = screenLayout
end

---Recalculate the current screen layout windows
function M.recalculateWindows()
  local spaceIdToWindows = getWindowsBySpaceId()
  sortWindows(currentScreenLayout.spaceIdToWindows, spaceIdToWindows)
  currentScreenLayout.spaceIdToWindows = spaceIdToWindows
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

---Get a map from space id to windows
---@return table<integer, hs.window[]>
function M.getSpaceIdToWindowsMap()
  return currentScreenLayout.spaceIdToWindows
end

M.create()
return M
