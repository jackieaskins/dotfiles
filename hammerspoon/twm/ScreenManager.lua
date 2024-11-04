local fnutils = require('fnutils')
local twmUtils = require('twm.utils')
local WindowManager = require('twm.WindowManager')

---Get current screen ids
---@return string[]
local function getCurrentScreenIds()
  local screenIds = fnutils.getKeys(twmUtils.getUserSpaceIdsByScreenId())
  table.sort(screenIds)
  return screenIds
end

---Find configuration for the current screen ids
---@param currentScreenIds string[]
---@return MonitorConfiguration | nil
local function findMonitorConfiguration(currentScreenIds)
  for _, monitorConfiguration in ipairs(CUSTOM.twmMonitorConfigurations or {}) do
    local screenIds = fnutils.getKeys(monitorConfiguration)
    table.sort(screenIds)

    if fnutils.iequals(currentScreenIds, screenIds) then
      return monitorConfiguration
    end
  end

  return nil
end

---Create a window manager for the current screen ids
---@param currentScreenIds string[]
---@return WindowManager
local function createWindowManager(currentScreenIds)
  local currentMonitorConfiguration = findMonitorConfiguration(currentScreenIds)
  if currentMonitorConfiguration then
    for screenId, spaceIds in pairs(twmUtils.getUserSpaceIdsByScreenId()) do
      local currentSpaceCount = #spaceIds
      local desiredSpaceCount = #currentMonitorConfiguration[screenId]

      if currentSpaceCount < desiredSpaceCount then
        for _ = 1, desiredSpaceCount - currentSpaceCount do
          hs.spaces.addSpaceToScreen(screenId, false)
        end
      end

      hs.spaces.closeMissionControl()
    end
  end

  return WindowManager.new(currentMonitorConfiguration)
end

---@class ScreenManager
---@field currentScreenIds string[]
---@field windowManager WindowManager
---@field screenWatcher hs.screen.watcher
local ScreenManager = {}
ScreenManager.__index = ScreenManager

---Create a new screen manager
---@return ScreenManager
function ScreenManager.new()
  local self = setmetatable({}, ScreenManager)

  self.currentScreenIds = getCurrentScreenIds()
  self.windowManager = createWindowManager(self.currentScreenIds)
  self.screenWatcher = hs.screen.watcher.new(function()
    local newScreenIds = getCurrentScreenIds()
    if newScreenIds ~= self.currentScreenIds then
      self.windowManager:stop()
      self.currentScreenIds = newScreenIds
      self.windowManager = createWindowManager(self.currentScreenIds):start()
    end
  end)

  return self
end

---Start the screen watcher and window manager
---@return ScreenManager
function ScreenManager:start()
  self.windowManager:start()
  self.screenWatcher:start()

  return self
end

---Stop the screen watcher and window manager
---@return ScreenManager
function ScreenManager:stop()
  self.windowManager:stop()
  self.screenWatcher:stop()

  return self
end

return ScreenManager
