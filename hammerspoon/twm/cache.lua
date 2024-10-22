local CACHE_KEY_PREFIX = 'twm.cache.'

local fnutils = require('fnutils')

---@class (exact) CachedScreenLayout
---@field screenIdToSpaceIds table<string, number[]>
---@field screenIdToFrame table<string, ScreenFrame>
---@field spaceIdToLayout table<string, string>
---@field spaceIdToWindowIds table<string, number[]>

local M = {}

---Get a stable identifying key for the current screen layout or provided screens
---@param screenIds? string[]
---@return string
function M.getScreenLayoutKey(screenIds)
  local sortedScreenIds = screenIds and hs.fnutils.copy(screenIds)
    or hs.fnutils.imap(hs.screen.allScreens() or {}, function(screen)
      return screen:getUUID()
    end)
    or {}

  table.sort(sortedScreenIds)

  return CACHE_KEY_PREFIX .. table.concat(sortedScreenIds, '.')
end

function M.loadLayout()
  local key = M.getScreenLayoutKey()

  ---@type CachedScreenLayout | nil
  local cachedLayout = hs.settings.get(key)

  if not cachedLayout then
    return nil
  end

  local function tointeger(str)
    return tonumber(str) --[[@as integer]]
  end

  local windowsById = {}
  for _, window in ipairs(require('twm.windowFilter'):getWindows()) do
    windowsById[window:id()] = window
  end

  ---@type ScreenLayout
  return {
    key = key,
    screenIdToSpaceIds = cachedLayout.screenIdToSpaceIds,
    screenIdToFrame = cachedLayout.screenIdToFrame,
    spaceIdToLayout = fnutils.mapKeys(cachedLayout.spaceIdToLayout, tointeger),
    spaceIdToWindows = fnutils.map(cachedLayout.spaceIdToWindowIds, function(spaceId, windowIds)
      return tointeger(spaceId),
        fnutils.ireduce(windowIds, function(windowId, windows)
          local window = windowsById[windowId]
          if window then
            table.insert(windows, window)
          end
          return windows
        end, {})
    end),
  }
end

---Save provided screen layout to cache
---@param screenLayout ScreenLayout
function M.saveLayout(screenLayout)
  local screenIds = fnutils.getKeys(screenLayout.screenIdToSpaceIds)

  ---@type CachedScreenLayout
  local cachedLayout = {
    screenIdToSpaceIds = screenLayout.screenIdToSpaceIds,
    screenIdToFrame = screenLayout.screenIdToFrame,
    spaceIdToLayout = fnutils.mapKeys(screenLayout.spaceIdToLayout, tostring),
    spaceIdToWindowIds = fnutils.map(screenLayout.spaceIdToWindows, function(spaceId, windows)
      ---@alias numbers number[]
      local windowIds = hs.fnutils.imap(windows, function(window)
        return window:id()
      end) --[[@as numbers]]

      return tostring(spaceId), windowIds
    end),
  }

  hs.settings.set(M.getScreenLayoutKey(screenIds), cachedLayout)
end

return M
