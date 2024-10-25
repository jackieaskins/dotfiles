local utils = require('twm.menubar.utils')

local menubar = hs.menubar.new(true, 'twm')

local function updateMenu()
  if menubar then
    menubar:setMenu(utils.getMenu())
  end
end

local M = {}

function M.update()
  local currentLayout = require('twm.layout').get()

  local currentSpaceId = hs.spaces.focusedSpace()
  local icon = currentLayout == 'stack' and '􀏭' or '􀇵'
  local currentSpaceWindows = hs.fnutils.filter(utils.menubarCurrentWF:getWindows(), function(window)
    return hs.fnutils.contains(hs.spaces.windowSpaces(window), currentSpaceId)
  end)

  if menubar then
    menubar:setTitle(icon .. ' ' .. tostring(#currentSpaceWindows))
  end
end

function M.init()
  if not menubar then
    return
  end

  utils.menubarCurrentWF:subscribe({
    hs.window.filter.windowsChanged,
    hs.window.filter.windowFocused,
  }, M.update)

  utils.menubarWF:subscribe({
    hs.window.filter.windowsChanged,
    hs.window.filter.windowMoved,
    hs.window.filter.windowTitleChanged,
    hs.window.filter.windowUnfullscreened,
    hs.window.filter.windowFullscreened,
    hs.window.filter.windowFocused,
  }, updateMenu)

  M.update()
  updateMenu()
end

return M
