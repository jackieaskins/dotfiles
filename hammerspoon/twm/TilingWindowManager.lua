local VirtualWorkspace = require('twm.VirtualWorkspace')
local windowFilter = require('twm.windowFilter')

local function deleteNonFocusedSpaces()
  -- TODO: Handle fullscreen
  for _, display in ipairs(hs.spaces.data_managedDisplaySpaces()) do
    for _, space in ipairs(display.Spaces) do
      if display['Current Space'] ~= space.ManagedSpaceID then
        hs.spaces.removeSpace(space.ManagedSpaceID, false)
      end
    end
  end

  hs.spaces.closeMissionControl()
end

---@class WFSubscription
---@field events string[]
---@field fn fun(window: hs.window, appName: string, event: string)

---@class InitialSpace
---@field layout string
---@field screenUUID string
---@field windows hs.window[]
---@field focused boolean

---@param windowsByBundleID table<string, hs.window[]>
---@return InitialSpace[]
local function getInitialSpaces(windowsByBundleID)
  local displayPreferences = require('twm.displayPreferences').loadOrCreate()

  local spaces = hs.fnutils.mapCat(displayPreferences, function(display)
    return fnutils.imap(display.spaces, function(space)
      local spaceWindows = hs.fnutils.mapCat(space.bundleIDs, function(bundleID)
        local windows = windowsByBundleID[bundleID] or {}
        -- Remove window once it's been added to a space so additional windows can be added
        windowsByBundleID[bundleID] = nil
        return windows
      end)

      return {
        layout = space.layout,
        screenUUID = display.screenUUID,
        windows = spaceWindows,
        focused = space.focused == true,
      }
    end)
  end)

  local windowsByScreenUUID = {}
  for _, windows in pairs(windowsByBundleID) do
    for _, window in ipairs(windows or {}) do
      local windowScreenUUID = window:screen():getUUID()
      local screenWindows = windowsByScreenUUID[windowScreenUUID] or {}
      table.insert(screenWindows, window)
      windowsByScreenUUID[windowScreenUUID] = screenWindows
    end
  end

  for screenUUID, windows in pairs(windowsByScreenUUID) do
    local focusedSpace = hs.fnutils.find(spaces, function(space)
      return space.screenUUID == screenUUID and space.focused
    end)

    focusedSpace.windows = hs.fnutils.concat(focusedSpace.windows, windows)
  end

  return spaces
end

---@class TilingWindowManager
---@field screenUUIDs string[]
---@field private virtualWorkspaces VirtualWorkspace[]
---@field private wfSubscriptions WFSubscription[]
local TilingWindowManager = {}
TilingWindowManager.__index = TilingWindowManager

---@return TilingWindowManager
function TilingWindowManager.new()
  local self = setmetatable({}, TilingWindowManager)

  self.wfSubscriptions = self:getWFSubscriptions()

  self.screenUUIDs = fnutils.imap(hs.spaces.data_managedDisplaySpaces(), function(display)
    return display['Display Identifier']
  end)

  deleteNonFocusedSpaces()
  local initialSpaces = getInitialSpaces(fnutils.igroupBy(windowFilter:getWindows(), function(window)
    return window:application():bundleID()
  end))

  self.virtualWorkspaces = fnutils.imap(initialSpaces, function(space, index)
    return VirtualWorkspace.new(index, space.screenUUID, space.windows, space.layout, space.focused)
  end)

  self:tile()
  for _, subscription in ipairs(self.wfSubscriptions) do
    windowFilter:subscribe(subscription.events, subscription.fn)
  end

  return self
end

---@private
---@param window hs.window
---@return VirtualWorkspace
function TilingWindowManager:findWindowWorkspace(window)
  return hs.fnutils.find(self.virtualWorkspaces, function(workspace)
    return workspace:hasWindow(window)
  end)
end

---@private
function TilingWindowManager:getWFSubscriptions()
  return {
    {
      events = { hs.window.filter.windowFocused },
      fn = function(window)
        self:focusWorkspace(self:findWindowWorkspace(window))
      end,
    },
    {
      events = { hs.window.filter.windowVisible, hs.window.filter.windowNotVisible },
      fn = function(window, _, event)
        local screenUUID = window:screen():getUUID()
        local workspace = self:getActiveWorkspace(screenUUID)

        if event == hs.window.filter.windowVisible then
          workspace:addWindow(window):tile()
        else
          workspace:removeWindow(window):tile()
        end
      end,
    },
    {
      events = { hs.window.filter.windowFullscreened, hs.window.filter.windowUnfullscreened },
      fn = function(window)
        self:findWindowWorkspace(window):tile()
      end,
    },
    {
      events = { hs.window.filter.windowMoved },
      fn = function(window)
        local newWindowScreenUUID = window:screen():getUUID()
        local currentWindowWorkspace = self:findWindowWorkspace(window)

        if newWindowScreenUUID == currentWindowWorkspace.screenUUID then
          currentWindowWorkspace:tile()
        else
          local newWindowWorkspace = self:getActiveWorkspace(newWindowScreenUUID)

          currentWindowWorkspace:removeWindow(window):tile()
          newWindowWorkspace:addWindow(window):tile()
        end
      end,
    },
  }
end

---@private
---@param direction 'West' | 'South' | 'North' | 'East'
---@return hs.window[]
function TilingWindowManager:getVisibleWindowsInDirection(direction)
  local allWindowsInDirection =
    windowFilter['windowsTo' .. direction](windowFilter, hs.window.focusedWindow(), false, true)

  local visibleWindows = hs.fnutils.mapCat(self.virtualWorkspaces, function(workspace)
    return workspace:getVisibleWindows()
  end)

  return hs.fnutils.filter(allWindowsInDirection, function(window)
    return hs.fnutils.some(visibleWindows, function(visibleWindow)
      return window:id() == visibleWindow:id()
    end)
  end)
end

---@private
---@param screenUUID string
---@return VirtualWorkspace
function TilingWindowManager:getActiveWorkspace(screenUUID)
  return hs.fnutils.find(self.virtualWorkspaces, function(workspace)
    return workspace.screenUUID == screenUUID and workspace.isActive
  end)
end

---@return VirtualWorkspace[]
function TilingWindowManager:getActiveWorkspaces()
  return hs.fnutils.ifilter(self.virtualWorkspaces, function(workspace)
    return workspace.isActive
  end)
end

---@param direction 'West' | 'South' | 'North' | 'East'
---@return TilingWindowManager
function TilingWindowManager:focusWindowInDirection(direction)
  local visibleWindows = self:getVisibleWindowsInDirection(direction)

  if #visibleWindows > 0 then
    visibleWindows[1]:focus()
  end

  return self
end

---@param direction 'West' | 'South' | 'North' | 'East'
---@return TilingWindowManager
function TilingWindowManager:swapWindowInDirection(direction)
  local focusedWindow = hs.window.focusedWindow()
  local visibleWindows = self:getVisibleWindowsInDirection(direction)

  if #visibleWindows > 0 then
    local focusedWorkspace = self:findWindowWorkspace(focusedWindow)
    local newWindow = visibleWindows[1]
    local newWorkspace = self:findWindowWorkspace(newWindow)

    if focusedWorkspace.id == newWorkspace.id then
      focusedWorkspace:swapWindows(focusedWindow, newWindow):tile()
    else
      focusedWorkspace:replaceWindow(focusedWindow, newWindow):tile()
      newWorkspace:replaceWindow(newWindow, focusedWindow):tile()
    end
  end

  return self
end

---@param workspaceOrIndex VirtualWorkspace | integer
---@return TilingWindowManager
function TilingWindowManager:focusWorkspace(workspaceOrIndex)
  local workspace = type(workspaceOrIndex) == 'number' and self.virtualWorkspaces[workspaceOrIndex] or workspaceOrIndex --[[@as VirtualWorkspace]]

  if workspace and not workspace.isActive then
    local activeWorkspace = self:getActiveWorkspace(workspace.screenUUID)
    activeWorkspace:unfocus()
    workspace:focus()

    local focusedWindow = hs.window.focusedWindow()
    if not workspace:hasWindow(focusedWindow) then
      local windows = workspace:getVisibleWindows()

      if #windows > 0 then
        windows[1]:focus()
      end
    end
  end

  return self
end

---@param workspaceOrIndex VirtualWorkspace | integer
---@return TilingWindowManager
function TilingWindowManager:moveFocusedWindowToWorkspace(workspaceOrIndex)
  local workspace = type(workspaceOrIndex) == 'number' and self.virtualWorkspaces[workspaceOrIndex] or workspaceOrIndex --[[@as VirtualWorkspace]]

  if workspace then
    local focusedWindow = hs.window.focusedWindow()
    local focusedWindowWorkspace = self:findWindowWorkspace(focusedWindow)

    focusedWindowWorkspace:removeWindow(focusedWindow):tile()
    workspace:addWindow(focusedWindow):tile()
  end

  return self
end

---@param screenIndex integer
---@return TilingWindowManager
function TilingWindowManager:moveFocusedWindowToScreen(screenIndex)
  local screenUUID = self.screenUUIDs[screenIndex]

  if screenUUID then
    self:moveFocusedWindowToWorkspace(self:getActiveWorkspace(screenUUID))
  end

  return self
end

---@return TilingWindowManager
function TilingWindowManager:tile()
  for _, workspace in ipairs(self.virtualWorkspaces) do
    workspace:tile()
  end

  return self
end

---@return TilingWindowManager
function TilingWindowManager:destroy()
  for _, subscription in ipairs(self.wfSubscriptions) do
    windowFilter:unsubscribe(subscription.events, subscription.fn)
  end

  return self
end

---@return TilingWindowManager
function TilingWindowManager:toggleWorkspaceLayout()
  local currentScreenUUID = hs.screen.mainScreen():getUUID()
  local focusedSpace = self:getActiveWorkspace(currentScreenUUID)

  local newLayout = focusedSpace.layout == 'stack' and 'tall' or 'stack'
  focusedSpace:setLayout(newLayout):tile()

  return self
end

return TilingWindowManager
