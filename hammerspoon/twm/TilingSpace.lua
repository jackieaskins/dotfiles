local SCREEN_PADDING = CUSTOM.twmScreenPadding or 14
local WINDOW_GAP = CUSTOM.twmWindowGap or 14
local windowFilter = require('twm.windowFilter')
local supportedLayouts = require('twm.supportedLayouts')

local DEFAULT_LAYOUT = 'tall'

---@class TilingSpace
---@field private spaceId number
---@field private previousLayout? string
---@field private layout string
---@field private windows hs.window[]
local TilingSpace = {}
TilingSpace.__index = TilingSpace

---@param spaceId number
---@param layout? string
---@param windows? hs.window[]
---@return TilingSpace
function TilingSpace.new(spaceId, layout, windows)
  local self = setmetatable({}, TilingSpace)

  self.spaceId = spaceId
  self.layout = layout or DEFAULT_LAYOUT
  self.windows = windows or {}

  return self
end

---Get space window filter
---@private
---@return hs.window[]
function TilingSpace:getSpaceWindows()
  local newWindows = {}

  for _, window in ipairs(windowFilter.getWindows()) do
    local windowSpaceId = hs.spaces.windowSpaces(window)[1]
    if windowSpaceId == self.spaceId then
      table.insert(newWindows, window)
    end
  end

  return newWindows
end

---Recalculate windows and tile space
---@return TilingSpace
function TilingSpace:tile()
  local newWindows = self:getSpaceWindows()

  table.sort(newWindows, function(a, b)
    local aIndex = hs.fnutils.indexOf(self.windows, a)
    local bIndex = hs.fnutils.indexOf(self.windows, b)

    -- Unstable sort fn was being returned when object compared against itself
    if aIndex == bIndex then
      return false
    end

    return (aIndex and bIndex) and (aIndex < bIndex) or not bIndex
  end)

  self.windows = newWindows

  local screenId = hs.spaces.spaceDisplay(self.spaceId)
  local screenFrame = hs.screen.find(screenId):frame()
  local paddedScreenFrame = {
    x = screenFrame.x + SCREEN_PADDING,
    y = screenFrame.y + SCREEN_PADDING,
    w = screenFrame.w - (SCREEN_PADDING * 2),
    h = screenFrame.h - (SCREEN_PADDING * 2),
  }

  if #self.windows == 1 then
    supportedLayouts.stack(self.windows, paddedScreenFrame, WINDOW_GAP)
  else
    supportedLayouts[self.layout](self.windows, paddedScreenFrame, WINDOW_GAP)
  end

  return self
end

---Toggle between stack and previous layout
---@return TilingSpace
function TilingSpace:toggleStackLayout()
  if self.layout == 'stack' then
    self.layout = self.previousLayout or DEFAULT_LAYOUT
  else
    self.previousLayout = self.layout
    self.layout = 'stack'
  end

  hs.alert.show('Layout: ' .. self.layout)

  return self
end

---Swap provided window with window in direction
---@private
---@param fnName 'windowToWest' | 'windowToSouth' | 'windowToNorth' | 'windowToEast'
---@param window hs.window
---@return TilingSpace
function TilingSpace:swapWindow(fnName, window)
  local targetWindow = windowFilter[fnName](window, self.spaceId)

  if targetWindow then
    local fromIndex = hs.fnutils.indexOf(self.windows, window)
    local toIndex = hs.fnutils.indexOf(self.windows, targetWindow)

    if fromIndex and toIndex then
      self.windows[fromIndex] = targetWindow
      self.windows[toIndex] = window
    end
  end

  return self
end

---Swap provided window with window to west
---@param window hs.window
---@return TilingSpace
function TilingSpace:swapWindowWest(window)
  return self:swapWindow('windowToWest', window)
end

---Swap provided window with window to south
---@param window hs.window
---@return TilingSpace
function TilingSpace:swapWindowSouth(window)
  return self:swapWindow('windowToSouth', window)
end

---Swap provided window with window to north
---@param window hs.window
---@return TilingSpace
function TilingSpace:swapWindowNorth(window)
  return self:swapWindow('windowToNorth', window)
end

---Swap provided window with window to east
---@param window hs.window
---@return TilingSpace
function TilingSpace:swapWindowEast(window)
  return self:swapWindow('windowToEast', window)
end

return TilingSpace
