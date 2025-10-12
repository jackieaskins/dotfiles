require('windowFilterFixes')

local hotkeyStore = require('hotkeyStore')

----------------------------------------------------------------------
--                              Custom                              --
----------------------------------------------------------------------

---@class Custom
---@field appKeys? table<string, string>
---@field twmScreenPadding? number
---@field twmWindowFilters? table<string, boolean | { [string]: any }>
---@field twmWindowGap? number
---@field twmStackGap? number
---@field twmDisplayPreferences? DisplayPreference[][]

local customExists, custom = pcall(require, 'custom')
---@type Custom
CUSTOM = customExists and custom or {}

----------------------------------------------------------------------
--                             Globals                              --
----------------------------------------------------------------------

fnutils = require('fnutils')
EventListener = require('EventListener')
function Print(...)
  local inspectTypes = { 'thread', 'userdata', 'table', 'function' }

  local mappedArgs = fnutils.imap({ ... }, function(arg)
    return hs.fnutils.contains(inspectTypes, type(arg)) and hs.inspect(arg) or arg
  end)

  print(table.unpack(mappedArgs))
end

----------------------------------------------------------------------
--                            Constants                             --
----------------------------------------------------------------------

BREW_PREFIX = os.getenv('HOMEBREW_PREFIX')

MEH = { 'option', 'shift', 'ctrl' }
HYPER = { 'option', 'shift', 'ctrl', 'cmd' }

----------------------------------------------------------------------
--                             Settings                             --
----------------------------------------------------------------------

hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)

----------------------------------------------------------------------
--                              Reload                              --
----------------------------------------------------------------------

reloadWatcher = hs.pathwatcher.new(hs.configdir, function(paths)
  for _, path in ipairs(paths) do
    if not path:match(hs.configdir .. '/annotations/generated') then
      hs.reload()
      break
    end
  end
end)
reloadWatcher:start()
hotkeyStore.register('Configuration', 'Reload Configuration', MEH, 'r', hs.reload)

----------------------------------------------------------------------
--                        Window Management                         --
----------------------------------------------------------------------

hs.window.setShadows(false)
hs.window.animationDuration = 0

require('appLauncher')
require('twm')

-- focusBorder = hs.drawing
--   .rectangle(hs.geometry.rect(0, 0, 0, 0))
--   :setStrokeColor({ hex = '#89b4fa', alpha = 1.0 })
--   :setFill(false)
--   :setStrokeWidth(12)
--   :setRoundedRectRadii(10, 10)
--
-- local function drawBorder()
--   focusBorder:hide()
--
--   local focusedWindow = hs.window.focusedWindow()
--
--   if focusedWindow and not focusedWindow:isFullScreen() then
--     local windowInfo = hs.fnutils.find(hs.window.list(false), function(info)
--       return info.kCGWindowNumber == focusedWindow:id()
--     end)
--
--     local frame = focusedWindow:frame()
--
--     focusBorder
--       :setFrame(hs.geometry.rect(frame.x - 4, frame.y - 4, frame.w + 8, frame.h + 8))
--       :setLevel(math.max(windowInfo.kCGWindowLayer - 1, hs.drawing.windowLevels.normal))
--       :orderBelow(focusedWindow)
--       :show()
--   end
-- end
--
-- drawBorder()
--
-- hs.window.filter.new(true):subscribe({
--   hs.window.filter.windowFocused,
--   hs.window.filter.windowUnfocused,
--   hs.window.filter.windowsChanged,
--   -- hs.window.filter.windowVisible,
--   -- hs.window.filter.windowNotVisible,
--   hs.window.filter.windowMoved,
-- }, drawBorder)
--
----------------------------------------------------------------------
--                            Dark Mode                             --
----------------------------------------------------------------------

darkModeNotification = hs.distributednotifications.new(function()
  require('darkMode').handleDarkModeChange()
end, 'AppleInterfaceThemeChangedNotification')
darkModeNotification:start()

----------------------------------------------------------------------
--                               Misc                               --
----------------------------------------------------------------------

require('annotations')
require('hs.ipc').cliInstall() -- Enables CLI

hotkeyStore.verify()
hotkeyStore.addMenubarItem()

hs.alert.show('Loaded Hammerspoon config')
