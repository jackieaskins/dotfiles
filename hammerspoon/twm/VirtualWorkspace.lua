local twmUtils = require('twm.utils')
local windowFilter = require('twm.windowFilter')

---@alias LayoutName 'floating' | 'stack' | 'tall' | 'rtall' | 'grid' | 'columns' | 'rows'

---@class VirtualWorkspace
---@field id integer
---@field screenUUID string
---@field isActive boolean
---@field screenFrame hs.geometry
---@field layout LayoutName
---@field private windowIds number[]
---@field private windowFilter hs.window.filter
local VirtualWorkspace = {}
VirtualWorkspace.__index = VirtualWorkspace

---Create a new virtual workspace
---@param id integer
---@param screenUUID string
---@param windows hs.window[]
---@param layout string
---@param isActive boolean
function VirtualWorkspace.new(id, screenUUID, windows, layout, isActive)
  local self = setmetatable({}, VirtualWorkspace)

  local frame = hs.screen.find(screenUUID):frame()

  self.id = id
  self.screenUUID = screenUUID
  -- TODO: Use values from custom
  self.screenFrame = hs.geometry.rect(frame.x + 14, frame.y + 14, frame.w - 28, frame.h - 28)
  self.layout = layout

  self.windowIds = fnutils.imap(windows, function(window)
    return window:id()
  end)

  self.isActive = isActive

  return self
end

---@private
---@return hs.window[]
function VirtualWorkspace:getWindows()
  local windowById = hs.fnutils.reduce(windowFilter:getWindows(), function(accum, window)
    accum[window:id()] = window
    return accum
  end, {})

  return fnutils.imap(self.windowIds, function(windowId)
    return windowById[windowId]
  end)
end

---@return hs.window[]
function VirtualWorkspace:getVisibleWindows()
  if not self.isActive then
    return {}
  end

  return hs.fnutils.ifilter(
    self:getWindows(),
    ---@param window hs.window
    function(window)
      return window:isVisible()
    end
  )
end

---@private
function VirtualWorkspace:showWindows()
  -- TODO: Use value from custom
  require('twm.supportedLayouts')[self.layout](self:getVisibleWindows(), self.screenFrame, 14)
end

---@private
function VirtualWorkspace:hideWindows()
  local nonFullScreenWindows = hs.fnutils.ifilter(self:getWindows(), function(window)
    return not window:isFullScreen()
  end)

  for _, window in ipairs(nonFullScreenWindows) do
    twmUtils.setWindowFrame(
      window,
      hs.geometry.rect(
        self.screenFrame.x + self.screenFrame.w - 1,
        self.screenFrame.y + self.screenFrame.h,
        window:frame().w,
        window:frame().h
      )
    )
  end
end

---@param newLayout LayoutName
---@return VirtualWorkspace
function VirtualWorkspace:setLayout(newLayout)
  self.layout = newLayout

  return self
end

function VirtualWorkspace:tile()
  if self.isActive then
    self:showWindows()
  else
    self:hideWindows()
  end

  return self
end

---@return VirtualWorkspace
function VirtualWorkspace:focus()
  local wasActive = self.isActive

  self.isActive = true
  self:showWindows()

  if not wasActive then
    EventListener.emitEvent(EventListener.events.activeSpacesChanged)
  end

  return self
end

---@return VirtualWorkspace
function VirtualWorkspace:unfocus()
  local wasActive = self.isActive

  self.isActive = false
  self:hideWindows()

  if wasActive then
    EventListener.emitEvent(EventListener.events.activeSpacesChanged)
  end

  return self
end

---@param window hs.window
---@return boolean
function VirtualWorkspace:hasWindow(window)
  return hs.fnutils.some(self.windowIds, function(windowId)
    return windowId == window:id()
  end)
end

---TODO: Figure out if we want to pass the window or window id here
---@param window hs.window
---@return VirtualWorkspace
function VirtualWorkspace:addWindow(window)
  table.insert(self.windowIds, window:id())

  return self
end

---@param window hs.window
---@return VirtualWorkspace
function VirtualWorkspace:removeWindow(window)
  self.windowIds = hs.fnutils.filter(self.windowIds, function(windowId)
    return windowId ~= window:id()
  end)

  return self
end

---@param oldWindow hs.window
---@param newWindow hs.window
---@return VirtualWorkspace
function VirtualWorkspace:replaceWindow(oldWindow, newWindow)
  self.windowIds = fnutils.imap(self.windowIds, function(windowId)
    return windowId == oldWindow:id() and newWindow:id() or windowId
  end)

  return self
end

---@param windowA hs.window
---@param windowB hs.window
---@return VirtualWorkspace
function VirtualWorkspace:swapWindows(windowA, windowB)
  --TODO: Handle window not on space
  local windowAIndex = hs.fnutils.indexOf(self.windowIds, windowA:id())
  local windowBIndex = hs.fnutils.indexOf(self.windowIds, windowB:id())

  assert(windowAIndex)
  assert(windowBIndex)

  self.windowIds[windowAIndex] = windowB:id()
  self.windowIds[windowBIndex] = windowA:id()

  return self
end

return VirtualWorkspace
