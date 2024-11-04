local fnutils = require('fnutils')
local TilingSpace = require('twm.TilingSpace')
local twmUtils = require('twm.utils')
local windowFilter = require('twm.windowFilter')

local wf = hs.window.filter

---@class SpaceConfiguration
---@field layout string
---@field appNames string[]

---@alias MonitorConfiguration { [string]: SpaceConfiguration[] }

---@class WindowManager
---@field private tilingSpaces { [number]: TilingSpace }
local WindowManager = {}
WindowManager.__index = WindowManager

---Create a new window manager
---@param monitorConfiguration? MonitorConfiguration
---@return WindowManager
function WindowManager.new(monitorConfiguration)
  local self = setmetatable({}, WindowManager)

  monitorConfiguration = monitorConfiguration or {}

  self.tilingSpaces = {}

  local windowsByAppName = fnutils.igroupBy(windowFilter.getWindows(), function(window)
    local app = window:application()
    return app and app:name() or ''
  end)

  for _, display in ipairs(hs.spaces.data_managedDisplaySpaces() or {}) do
    local screenId = display['Display Identifier']
    local layoutSpaces = monitorConfiguration[screenId] or {}

    for index, space in ipairs(display.Spaces) do
      local spaceId = space.ManagedSpaceID
      local layoutSpace = layoutSpaces[index]

      if layoutSpace then
        local windows = {}
        for _, appName in ipairs(layoutSpace.appNames) do
          for _, window in pairs(windowsByAppName[appName] or {}) do
            hs.spaces.moveWindowToSpace(window, spaceId)
            table.insert(windows, window)
          end
        end

        self.tilingSpaces[spaceId] = TilingSpace.new(spaceId, layoutSpace.layout, windows)
      else
        self.tilingSpaces[spaceId] = TilingSpace.new(spaceId)
      end
    end
  end

  return self
end

---Start window watcher and start tiling
---@return WindowManager
function WindowManager:start()
  windowFilter.subscribe({
    wf.windowsChanged,
    wf.windowMoved,
    wf.windowAllowed,
    wf.windowRejected,
    wf.windowNotInCurrentSpace,
    wf.windowInCurrentSpace,
    wf.windowTitleChanged,
  }, function()
    self:retile()
  end)

  self:tile()

  return self
end

---Stop the window watcher
---@return WindowManager
function WindowManager:stop()
  windowFilter.unsubscribeAll()

  return self
end

---Tile all of the spaces
---@return WindowManager
function WindowManager:tile()
  for _, tilingSpace in pairs(self.tilingSpaces) do
    tilingSpace:tile()
  end

  return self
end

---Recalculate spaces and tile
---@return WindowManager
function WindowManager:retile()
  local newTilingSpaces = {}

  for _, spaceIds in pairs(twmUtils.getUserSpaceIdsByScreenId()) do
    for _, spaceId in ipairs(spaceIds) do
      newTilingSpaces[spaceId] = self.tilingSpaces[spaceId] or TilingSpace.new(spaceId)
    end
  end

  self.tilingSpaces = newTilingSpaces

  return self:tile()
end

---Toggle stack layout for space
---@param spaceId number
---@return WindowManager
function WindowManager:toggleStackLayout(spaceId)
  local tilingSpace = self.tilingSpaces[spaceId]

  if tilingSpace then
    tilingSpace:toggleStackLayout():tile()
  end

  return self
end

---Swap focused window with window in direction
---@private
---@param fnName 'swapWindowWest' | 'swapWindowSouth' | 'swapWindowNorth' | 'swapWindowEast'
---@return WindowManager
function WindowManager:swapWindow(fnName)
  local window = hs.window.focusedWindow()

  if not windowFilter.isWindowAllowed(window) then
    return self
  end

  local spaceId = hs.spaces.windowSpaces(window)[1]
  local tilingSpace = self.tilingSpaces[spaceId]

  if tilingSpace then
    tilingSpace[fnName](tilingSpace, window):tile()
  end

  return self
end

---Swap focused window with window to west
---@return WindowManager
function WindowManager:swapWindowWest()
  return self:swapWindow('swapWindowWest')
end

---Swap focused window with window to south
---@return WindowManager
function WindowManager:swapWindowSouth()
  return self:swapWindow('swapWindowSouth')
end

---Swap focused window with window to north
---@return WindowManager
function WindowManager:swapWindowNorth()
  return self:swapWindow('swapWindowNorth')
end

---Swap focused window with window to east
---@return WindowManager
function WindowManager:swapWindowEast()
  return self:swapWindow('swapWindowEast')
end

return WindowManager
