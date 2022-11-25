local cache = require('twm.cache')
local layout = require('twm.layout')
local utils = require('twm.utils')

local M = {}

-- Lifecyle {{{
---Start tiling windows on all spaces
function M.start()
  cache.windowFilter:subscribe({
    hs.window.filter.windowsChanged,
    hs.window.filter.windowInCurrentSpace,
    hs.window.filter.windowNotInCurrentSpace,
    hs.window.filter.windowFocused,
  }, M.tile)
  M.tile()
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

  local isFloating = cache.floatingWindows[window:id()] or false
  cache.floatingWindows[window:id()] = not isFloating

  M.tile()
end
-- }}}

-- Layouts {{{
---Bring up the picker to choose the current space layout
function M.chooseLayout()
  layout.choose()
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
  (win or hs.window.focusedWindow()):focusWindowWest()
end

---Change focus to the nearest window to the south
---@param win hs.window
function M.focusWindowSouth(win)
  (win or hs.window.focusedWindow()):focusWindowSouth()
end

---Change focus to the nearest window to the north
---@param win hs.window
function M.focusWindowNorth(win)
  (win or hs.window.focusedWindow()):focusWindowNorth()
end

---Change focus to the nearest window to the east
---@param win hs.window
function M.focusWindowEast(win)
  (win or hs.window.focusedWindow()):focusWindowEast()
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
