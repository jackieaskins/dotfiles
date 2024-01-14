local cache = require('twm.cache')
local windowFilter = require('twm.windowFilter')
local supportedLayouts = require('twm.supportedLayouts')

local SCREEN_PADDING = 10
local WINDOW_GAP = 10

local M = {}

---Sort the new windows based on the current order
---@param windows hs.window[]
---@param cachedWindowIds string[]
---@return hs.window[]
function M.getSortedSpaceWindows(windows, cachedWindowIds)
  table.sort(windows, function(a, b)
    local aIndex = hs.fnutils.indexOf(cachedWindowIds, a:id())
    local bIndex = hs.fnutils.indexOf(cachedWindowIds, b:id())

    -- Unstable sort fn was being returned when object compared against itself
    if aIndex == bIndex then
      return false
    end

    return (aIndex and bIndex) and (aIndex < bIndex) or not bIndex
  end)

  return windows
end

---Get a map from space id to window list
---@return table<string, hs.window[]>
function M.getWindowsBySpaceMap()
  local windowsBySpace = {}

  for _, window in ipairs(windowFilter:getWindows()) do
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
    hs.fnutils.filter(windowsBySpace[spaceId] or {}, function(window)
      return not M.isFloating(window)
    end),
    cache.getSpaceWindows(spaceId) or {}
  )

  local currentLayout = cache.getSpaceLayout(spaceId) or 'tall'
  cache.setSpaceLayout(spaceId, currentLayout)
  cache.setSpaceWindows(
    spaceId,
    hs.fnutils.map(windows, function(window)
      return window:id()
    end)
  )

  if #windows == 0 then
    return
  end

  local screenFrame = windows[1]:screen():frame()
  local screenFrameWithPadding = {
    x = screenFrame.x + SCREEN_PADDING,
    y = screenFrame.y + SCREEN_PADDING,
    w = screenFrame.w - (SCREEN_PADDING * 2),
    h = screenFrame.h - (SCREEN_PADDING * 2),
  }

  if #windows == 1 then
    supportedLayouts.monocle(windows, screenFrameWithPadding, WINDOW_GAP)
  else
    supportedLayouts[currentLayout](windows, screenFrameWithPadding, WINDOW_GAP)
  end
end

---Tile windows on all screens
function M.tile()
  local windowsBySpace = M.getWindowsBySpaceMap()
  for _, spaceIds in pairs(hs.spaces.allSpaces() or {}) do
    for _, spaceId in ipairs(spaceIds) do
      if hs.spaces.spaceType(spaceId) == 'user' then
        M.tileSpace(spaceId, windowsBySpace)
      end
    end
  end
end

---Focus the window to the left of the window in the space windows list
---@param window hs.window
function M.focusWindowToLeft(window)
  local space = hs.spaces.windowSpaces(window)[1]
  local windows = cache.getSpaceWindows(space) or {}
  local windowIndex = hs.fnutils.indexOf(windows, window:id())
  local nextWindowIndex = windowIndex == 1 and #windows or windowIndex - 1

  hs.window.get(windows[nextWindowIndex]):focus()
end

---Focus the window to the right of the window in the space windows list
---@param window hs.window
function M.focusWindowToRight(window)
  local space = hs.spaces.windowSpaces(window)[1]
  local windows = cache.getSpaceWindows(space) or {}
  local windowIndex = hs.fnutils.indexOf(windows, window:id())
  local nextWindowIndex = windowIndex == #windows and 1 or windowIndex + 1

  hs.window.get(windows[nextWindowIndex]):focus()
end

---Get windows in direction
---@param window hs.window
---@param dir 'west'|'south'|'north'|'east'
function M.windowsToDir(window, dir)
  if dir == 'west' then
    return windowFilter:windowsToWest(window, false, true)
  elseif dir == 'south' then
    return windowFilter:windowsToSouth(window, false, true)
  elseif dir == 'north' then
    return windowFilter:windowsToNorth(window, false, true)
  elseif dir == 'east' then
    return windowFilter:windowsToEast(window, false, true)
  end
end

---Swap window in direction
---@param window hs.window
---@param dir 'west'|'south'|'north'|'east'
function M.swapWindow(window, dir)
  if not M.isTiled(window) then
    return
  end

  local windows = M.windowsToDir(window, dir) or {}
  local spaceId = hs.spaces.windowSpaces(window)[1]
  local spaceWindows = cache.getSpaceWindows(spaceId)

  for _, win in ipairs(windows) do
    if hs.fnutils.contains(spaceWindows, win:id()) then
      local firstIndex = hs.fnutils.indexOf(spaceWindows, window:id())
      local secondIndex = hs.fnutils.indexOf(spaceWindows, win:id())

      if firstIndex and secondIndex then
        cache.setSpaceWindow(spaceId, firstIndex, win)
        cache.setSpaceWindow(spaceId, secondIndex, window)
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
  return cache.getFloatingWindow(window:id()) or false
end

return M
