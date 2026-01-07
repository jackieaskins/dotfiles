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
