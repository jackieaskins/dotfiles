local floatingWindows = {}
local spaceLayouts = {}
local spaceWindows = {}

local CACHE_KEY = 'twm.cache'

local M = {}

function M.getFloatingWindow(windowId)
  return floatingWindows[tostring(windowId)]
end

function M.setFloatingWindow(windowId, isFloating)
  floatingWindows[tostring(windowId)] = isFloating
end

function M.getSpaceLayout(space)
  return spaceLayouts[tostring(space)]
end

function M.setSpaceLayout(space, layout)
  spaceLayouts[tostring(space)] = layout
end

function M.getSpaceWindows(space)
  return spaceWindows[tostring(space)]
end

function M.setSpaceWindows(space, windows)
  spaceWindows[tostring(space)] = windows
end

function M.setSpaceWindow(space, index, window)
  spaceWindows[tostring(space)][index] = window:id()
end

function M.save()
  hs.settings.set(
    CACHE_KEY,
    hs.json.encode({
      floatingWindows = hs.fnutils.filter(floatingWindows, function(isFloating)
        return isFloating
      end),
      spaceLayouts = spaceLayouts,
      spaceWindows = spaceWindows,
    })
  )
end

function M.restore()
  local cached_settings = hs.settings.get(CACHE_KEY)
  local cache = cached_settings and hs.json.decode(cached_settings) or {}

  floatingWindows = cache.floatingWindows or {}
  spaceLayouts = cache.spaceLayouts or {}
  spaceWindows = cache.spaceWindows or {}
end

function M.reset()
  hs.settings.clear(CACHE_KEY)
end

return M
