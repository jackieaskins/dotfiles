local utils = require('config.twm.menubar.utils')

local menubar = hs.menubar.new()

local function updateMenu()
  if menubar then
    menubar:setMenu(utils.getMenu())
  end
end

local M = {}

function M.update()
  local currentLayout = require('config.twm.layout').get()

  local icon = currentLayout == 'monocle' and '􀏭' or '􀇵'
  local currentSpaceWindows = utils.menubarCurrentWF:getWindows() or {}

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
