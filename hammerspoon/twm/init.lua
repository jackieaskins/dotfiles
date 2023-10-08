local cache = require('twm.cache')
local layout = require('twm.layout')
local utils = require('twm.utils')
local windowFilter = require('twm.windowFilter')

local M = {}

-- Lifecyle {{{
---Load from cache and start tiling windows on all spaces
function M.start()
  cache.restore()

  windowFilter:subscribe({
    hs.window.filter.windowsChanged,
    hs.window.filter.windowInCurrentSpace,
    hs.window.filter.windowNotInCurrentSpace,
    hs.window.filter.windowFocused,
  }, M.tile)

  windowFilter:subscribe({
    hs.window.filter.windowMinimized,
    hs.window.filter.windowDestroyed,
  }, function()
    for _, window in ipairs(hs.window.filter.defaultCurrentSpace:getWindows()) do
      if window:isVisible() then
        window:focus()
        return
      end
    end
  end)

  M.tile()
end

---Reset tiling cache and re-tile
function M.reset()
  cache.reset()
  M.tile()
end

---Save current tiling cache
function M.stop()
  cache.save()
end
-- }}}

-- Tiling {{{
---Manually trigger tiling for all spaces
function M.tile()
  utils.tile()
end

---Toggle float for the current window
---@param win hs.window
function M.toggleFloat(win)
  local window = win or hs.window.focusedWindow()

  local isFloating = cache.getFloatingWindow(window:id()) or false
  cache.setFloatingWindow(window:id(), not isFloating)

  M.tile()
end
-- }}}

-- Layouts {{{
---Bring up the picker to choose the current space layout
function M.chooseLayout()
  layout.choose()
end

---Get the current space layout
function M.getLayout()
  return layout.get()
end

---Show an alert with the current space layout
function M.showLayout()
  layout.show()
end

---Set layout for the current space
---@param layoutName string
function M.setLayout(layoutName)
  layout.set(layoutName)
end
-- }}}

-- Window Focus {{{
---Change focus to the nearest window to the west
---@param win hs.window
function M.focusWindowWest(win)
  local window = win or hs.window.focusedWindow()
  if not window:focusWindowWest() then
    utils.focusWindowToLeft(window)
  end
end

---Change focus to the nearest window to the south
---@param win hs.window
function M.focusWindowSouth(win)
  local window = win or hs.window.focusedWindow()
  if not window:focusWindowSouth() then
    utils.focusWindowToRight(window)
  end
end

---Change focus to the nearest window to the north
---@param win hs.window
function M.focusWindowNorth(win)
  local window = win or hs.window.focusedWindow()
  if not window:focusWindowNorth() then
    utils.focusWindowToLeft(window)
  end
end

---Change focus to the nearest window to the east
---@param win hs.window
function M.focusWindowEast(win)
  local window = win or hs.window.focusedWindow()
  if not window:focusWindowEast() then
    utils.focusWindowToRight(window)
  end
end
-- }}}

-- Window Swap {{{
---Swap window focus to the nearest tiled window to the west
---@param win hs.window
function M.swapWindowWest(win)
  utils.swapWindow(win or hs.window.focusedWindow(), 'west')
end

---Swap window focus to the nearest tiled window to the south
---@param win hs.window
function M.swapWindowSouth(win)
  utils.swapWindow(win or hs.window.focusedWindow(), 'south')
end

---Swap window focus to the nearest tiled window to the north
---@param win hs.window
function M.swapWindowNorth(win)
  utils.swapWindow(win or hs.window.focusedWindow(), 'north')
end

---Swap window focus to the nearest tiled window to the east
---@param win hs.window
function M.swapWindowEast(win)
  utils.swapWindow(win or hs.window.focusedWindow(), 'east')
end

return M
-- }}}

-- vim:foldmethod=marker
