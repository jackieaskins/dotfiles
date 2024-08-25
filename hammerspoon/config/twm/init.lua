local cache = require('config.twm.cache')
local layout = require('config.twm.layout')
local utils = require('config.twm.utils')
local windowFilter = require('config.twm.windowFilter')
local menubar = require('config.twm.menubar')

local wf = hs.window.filter

local M = {}

-- Lifecyle {{{
---Load from cache and start tiling windows on all spaces
function M.start()
  cache.restore()

  windowFilter:subscribe({
    wf.windowsChanged,
    wf.windowInCurrentSpace,
    wf.windowNotInCurrentSpace,
    wf.windowMoved, -- Hopefully this doesn't lead to an infintie loop :)
  }, M.tile)

  M.tile()
  menubar.init()
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
---@param win hs.window?
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
---@param win hs.window?
function M.focusWindowWest(win)
  local window = win or hs.window.focusedWindow()
  if not window:focusWindowWest() then
    utils.focusWindowToLeft(window)
  end
end

---Change focus to the nearest window to the south
---@param win hs.window?
function M.focusWindowSouth(win)
  local window = win or hs.window.focusedWindow()
  if not window:focusWindowSouth() then
    utils.focusWindowToRight(window)
  end
end

---Change focus to the nearest window to the north
---@param win hs.window?
function M.focusWindowNorth(win)
  local window = win or hs.window.focusedWindow()
  if not window:focusWindowNorth() then
    utils.focusWindowToLeft(window)
  end
end

---Change focus to the nearest window to the east
---@param win hs.window?
function M.focusWindowEast(win)
  local window = win or hs.window.focusedWindow()
  if not window:focusWindowEast() then
    utils.focusWindowToRight(window)
  end
end
-- }}}

-- Window Swap {{{
---Swap window focus to the nearest tiled window to the west
---@param win hs.window?
function M.swapWindowWest(win)
  utils.swapWindow(win or hs.window.focusedWindow(), 'west')
end

---Swap window focus to the nearest tiled window to the south
---@param win hs.window?
function M.swapWindowSouth(win)
  utils.swapWindow(win or hs.window.focusedWindow(), 'south')
end

---Swap window focus to the nearest tiled window to the north
---@param win hs.window?
function M.swapWindowNorth(win)
  utils.swapWindow(win or hs.window.focusedWindow(), 'north')
end

---Swap window focus to the nearest tiled window to the east
---@param win hs.window?
function M.swapWindowEast(win)
  utils.swapWindow(win or hs.window.focusedWindow(), 'east')
end
-- }}}

-- Window Space Movement {{{
---Move window to provided space
---@param desktopNum number
---@return fun(win?: hs.window)
function M.moveWindowToSpace(desktopNum)
  return function(win)
    local spaceId = utils.getSpaceId(desktopNum)

    if not spaceId then
      hs.alert.show('Desktop ' .. desktopNum .. ' does not exist')
      return
    end

    local window = win or hs.window.focusedWindow()
    hs.spaces.moveWindowToSpace(window, spaceId)

    -- Use ctrl+num mapping to go to screen
    -- This is smoother than hs.spaces.goToSpace
    hs.eventtap.keyStroke({ 'ctrl' }, tostring(desktopNum))

    -- Refocus window
    hs.window.get(window:id()):focus()
  end
end
-- }}}

return M

-- vim:foldmethod=marker
