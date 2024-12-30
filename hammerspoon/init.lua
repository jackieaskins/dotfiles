local fnutils = require('fnutils')
local hotkeyStore = require('hotkeyStore')

----------------------------------------------------------------------
--                              Custom                              --
----------------------------------------------------------------------

---@class Custom
---@field appKeys? table<string, string>
---@field twmScreenPadding? number
---@field twmWindowFilters? table<string, boolean>
---@field twmWindowGap? number
---@field twmStackGap? number
---@field twmMonitorConfigurations? MonitorConfiguration[]

local ok, custom = pcall(require, 'custom')
---@type Custom
CUSTOM = ok and custom or {}

----------------------------------------------------------------------
--                             Globals                              --
----------------------------------------------------------------------

function Print(...)
  local inspectTypes = { 'thread', 'userdata', 'table', 'function' }

  local mappedArgs = hs.fnutils.imap({ ... }, function(arg)
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
--                             Hotkeys                              --
----------------------------------------------------------------------

hotkeyStore.register('Reload', 'Reload configuration', MEH, 'r', hs.reload)

local appKeyMods = { 'option', 'control' }
local appKeys = fnutils.mergeTables({
  m = 'Music',
  n = 'Notes',
  t = 'Ghostty',
}, CUSTOM.appKeys or {})

for key, app in pairs(appKeys) do
  hotkeyStore.register('Application Launchers', 'Open ' .. app, appKeyMods, key, function()
    hs.application.launchOrFocus(app)
  end)
end

----------------------------------------------------------------------
--                        Window Management                         --
----------------------------------------------------------------------

hs.window.setShadows(false)
hs.window.animationDuration = 0

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
require('hs.ipc').cliInstall(BREW_PREFIX) -- Enables CLI
hotkeyStore.verify()
hotkeyStore.addMenubarItem()

hs.alert.show('Loaded HammerSpoon config')
