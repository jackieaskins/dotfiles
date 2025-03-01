local fnutils = require('fnutils')
local twmHotKeys = require('twm.hotkeys')
local windowFilter = require('twm.windowFilter')
local VirtualWorkspace = require('twm.VirtualWorkspace')

local wf = hs.window.filter

---@class TilingWindowManager
---@field private workspaces VirtualWorkspace[]
---@field private screenUUIDToActiveWorkspace table<string, VirtualWorkspace>
---@field private screenUUIDToWorkspaces table<string, VirtualWorkspace[]>
---@field private windowIdToWorkspace table<number, VirtualWorkspace>
---@field private windowSubscriptions table<string | string[], function>
local TilingWindowManager = {}
TilingWindowManager.__index = TilingWindowManager

---@private
---@param savedWorkspaces table<string, SavedWorkspace[]>
function TilingWindowManager:generateVirtualWorkspaces(savedWorkspaces)
  local windows = windowFilter:getWindows()
  local windowsByAppName = fnutils.igroupBy(windows, function(window)
    return window:application():title()
  end)

  for screenUUID, defaultLayouts in pairs(savedWorkspaces) do
    local activeWorkspaceId = #self.workspaces + 1

    for _, defaultLayout in ipairs(defaultLayouts) do
      local workspaceId = #self.workspaces + 1
      local workspace = VirtualWorkspace.new(workspaceId, screenUUID, defaultLayout, windowsByAppName)

      for _, windowId in ipairs(workspace:getWindowIds()) do
        self.windowIdToWorkspace[windowId] = workspace
      end

      local screenWorkspaces = self.screenUUIDToWorkspaces[screenUUID] or {}
      table.insert(screenWorkspaces, workspace)
      self.screenUUIDToWorkspaces[screenUUID] = screenWorkspaces

      table.insert(self.workspaces, workspace)
    end

    self.screenUUIDToActiveWorkspace[screenUUID] = self.workspaces[activeWorkspaceId]
  end

  for _, window in ipairs(windows) do
    local windowId = window:id()

    if windowId and not self.windowIdToWorkspace[windowId] then
      local activeWorkspace = self.screenUUIDToActiveWorkspace[window:screen():getUUID()]
      activeWorkspace:addWindow(window)
      self.windowIdToWorkspace[windowId] = activeWorkspace
    end
  end
end

---Generate a tiling workspace
---@param savedWorkspaces table<string, SavedWorkspace[]>
---@return TilingWindowManager
function TilingWindowManager.new(savedWorkspaces)
  local self = setmetatable({}, TilingWindowManager)

  self.workspaces = {}
  self.screenUUIDToActiveWorkspace = {}
  self.screenUUIDToWorkspaces = {}
  self.windowIdToWorkspace = {}
  self.windowSubscriptions = {
    [wf.windowFocused] = function(window)
      local workspace = self:getWindowWorkspace(window)

      if workspace then
        self:switchToWorkspace(workspace)
      end
    end,
    [{ wf.windowDestroyed, wf.windowMinimized }] = function(window)
      self:removeWindow(window)
    end,
    ---@param window hs.window
    [{ wf.windowCreated, wf.windowUnminimized }] = function(window)
      self:addWindow(window)
    end,
  }

  require('twm.utils').removeExtraSpaces()

  self:generateVirtualWorkspaces(savedWorkspaces)

  twmHotKeys.register(self)

  for event, fn in pairs(self.windowSubscriptions) do
    windowFilter:subscribe(event, fn)
  end

  for screenUUID, workspaces in pairs(self.screenUUIDToWorkspaces) do
    local activeWorkspace = self.screenUUIDToActiveWorkspace[screenUUID]
    for _, workspace in ipairs(workspaces) do
      if workspace.id == activeWorkspace.id then
        workspace:focus()
      else
        workspace:hideWindows()
      end
    end
  end

  return self
end

---Get window's current workspace
---@param window hs.window
---@return VirtualWorkspace | nil
function TilingWindowManager:getWindowWorkspace(window)
  return self.windowIdToWorkspace[window:id()]
end

---Get number of current workspaces
---@return integer
function TilingWindowManager:getWorkspaceCount()
  return #self.workspaces
end

---Get visible windows
---@return hs.window[]
function TilingWindowManager:getVisibleWindows()
  local visibleWindows = {}

  for _, workspace in pairs(self.screenUUIDToActiveWorkspace) do
    hs.fnutils.concat(visibleWindows, workspace:getWindows())
  end

  return visibleWindows
end

---Check if workspace is active on screen
---@param workspace VirtualWorkspace
---@return boolean
function TilingWindowManager:isWorkspaceActive(workspace)
  local screenUUID = workspace.screen:getUUID()
  local activeWorkspace = self.screenUUIDToActiveWorkspace[screenUUID]

  return activeWorkspace.id == workspace.id
end

---Add window to workspace
---@param window hs.window
---@param workspaceId? number
function TilingWindowManager:addWindow(window, workspaceId)
  local windowId = window:id()
  assert(windowId)

  local windowScreenUUID = window:screen():getUUID()
  local workspace = self.workspaces[workspaceId] or self.screenUUIDToActiveWorkspace[windowScreenUUID]

  workspace:addWindow(window)
  self.windowIdToWorkspace[windowId] = workspace

  if self:isWorkspaceActive(workspace) then
    workspace:showWindows()
  end
end

---Remove window from tiling window manager
---@param window hs.window
function TilingWindowManager:removeWindow(window)
  local windowId = window:id()
  assert(windowId)

  local workspace = self.windowIdToWorkspace[windowId]
  workspace:removeWindow(window)
  self.windowIdToWorkspace[windowId] = nil

  if self:isWorkspaceActive(workspace) then
    workspace:focus()
  end
end

---Switch to the provided workspace
---@param workspace VirtualWorkspace | number
function TilingWindowManager:switchToWorkspace(workspace)
  if type(workspace) == 'number' then
    workspace = self.workspaces[workspace]
  end

  local screenUUID = workspace.screen:getUUID()
  local activeWorkspace = self.screenUUIDToActiveWorkspace[screenUUID]

  if activeWorkspace.id == workspace.id then
    return
  end

  self.screenUUIDToActiveWorkspace[screenUUID] = workspace
  activeWorkspace:hideWindows()
  workspace:focus()
end

---Delete window filter subscriptions and unmap hotkeys
function TilingWindowManager:destroy()
  for event, fn in pairs(self.windowSubscriptions) do
    windowFilter:unsubscribe(event, fn)
  end

  twmHotKeys.unregister()
end

return TilingWindowManager
