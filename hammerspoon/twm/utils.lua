local cache = require('twm.cache')
local supportedLayouts = require('twm.supportedLayouts')

local M = {}

---Sort the new windows based on the current order
---@param windows hs.window[]
---@param cachedWindowIds string[]
---@return hs.window[]
function M.getSortedSpaceWindows(windows, cachedWindowIds)
  table.sort(windows, function(a, b)
    local aIndex = hs.fnutils.indexOf(cachedWindowIds, a:id())
    local bIndex = hs.fnutils.indexOf(cachedWindowIds, b:id())

    return (aIndex and bIndex) and (aIndex < bIndex) or not bIndex
  end)

  return windows
end

---Get a map from space id to window list
---@return table<string, hs.window[]>
function M.getWindowsBySpaceMap()
  local windowsBySpace = {}

  for _, window in ipairs(cache.windowFilter:getWindows()) do
    local spaceIds = hs.spaces.windowSpaces(window)
    if not spaceIds or #spaceIds ~= 1 then
      print('Window is included on multiple screens, not tiling it')
    else
      local spaceId = spaceIds[1]
      local windows = windowsBySpace[spaceId] or {}
      table.insert(windows, window)
      windowsBySpace[spaceId] = windows
    end
  end

  return windowsBySpace
end

---Tile windows on specified space id
---@param spaceId string
---@param windowsBySpace table<string, hs.window[]>
function M.tileSpace(spaceId, windowsBySpace)
  local windows = M.getSortedSpaceWindows(
    ---@diagnostic disable-next-line: param-type-mismatch
    hs.fnutils.filter(windowsBySpace[spaceId], function(window)
      return not M.isFloating(window)
    end),
    cache.spaceWindows[spaceId] or {}
  )

  local currentLayout = cache.spaceLayouts[spaceId] or 'tall'
  cache.spaceLayouts[spaceId] = currentLayout
  cache.spaceWindows[spaceId] = hs.fnutils.map(windows, function(window)
    return window:id()
  end)

  if #windows == 0 then
    return
  end

  local screenFrame = windows[1]:screen():frame()
  if #windows == 1 then
    supportedLayouts.monocle(windows, screenFrame)
  else
    supportedLayouts[currentLayout](windows, screenFrame)
  end
end

---Tile windows on all screens
function M.tile()
  local windowsBySpace = M.getWindowsBySpaceMap()
  for _, spaceIds in pairs(hs.spaces.allSpaces()) do
    for _, spaceId in ipairs(spaceIds) do
      if hs.spaces.spaceType(spaceId) == 'user' then
        M.tileSpace(spaceId, windowsBySpace)
      end
    end
  end
end

---Get windows in direction
---@param window hs.window
---@param dir 'west'|'south'|'north'|'east'
function M.windowsToDir(window, dir)
  if dir == 'west' then
    return cache.windowFilter:windowsToWest(window, false, true)
  elseif dir == 'south' then
    return cache.windowFilter:windowsToSouth(window, false, true)
  elseif dir == 'north' then
    return cache.windowFilter:windowsToNorth(window, false, true)
  elseif dir == 'east' then
    return cache.windowFilter:windowsToEast(window, false, true)
  end
end

---Swap window in direction
---@param window hs.window
---@param dir 'west'|'south'|'north'|'east'
function M.swapWindow(window, dir)
  if not M.isTiled(window) then
    return
  end

  local windows = M.windowsToDir(window, dir)
  local spaceId = hs.spaces.windowSpaces(window)[1]
  local spaceWindows = cache.spaceWindows[spaceId]

  for _, win in ipairs(windows) do
    if hs.fnutils.contains(spaceWindows, win:id()) then
      local firstIndex = hs.fnutils.indexOf(spaceWindows, window:id())
      local secondIndex = hs.fnutils.indexOf(spaceWindows, win:id())

      if firstIndex and secondIndex then
        cache.spaceWindows[spaceId][firstIndex] = win:id()
        cache.spaceWindows[spaceId][secondIndex] = window:id()
        M.tile()
      end
    end
  end
end

---Return whether a window is currently tiled
---@param window hs.window
---@return boolean
function M.isTiled(window)
  return (not M.isFloating(window)) and #hs.spaces.windowSpaces(window) == 1
end

---Return whether a window is floating
---@param window hs.window
---@return boolean
function M.isFloating(window)
  return cache.floatingWindows[window:id()] or false
end

return M
