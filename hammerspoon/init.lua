local fnutils = require('config.fnutils')
local hotkeyStore = require('config.hotkeyStore')

----------------------------------------------------------------------
--                              Custom                              --
----------------------------------------------------------------------

---@class Custom
---@field appKeys? table<string, string>
---@field brewPrefix? string
---@field twmScreenPadding? number
---@field twmWindowFilters? table<string, boolean>
---@field twmWindowGap? number

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

BREW_PREFIX = CUSTOM.brewPrefix or '/opt/homebrew'

MEH = { 'option', 'shift', 'ctrl' }
HYPER = { 'option', 'shift', 'ctrl', 'cmd' }

----------------------------------------------------------------------
--                              Spoons                              --
----------------------------------------------------------------------

hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall:andUse('EmmyLua')
spoon.SpoonInstall:asyncUpdateAllRepos()

----------------------------------------------------------------------
--                              Reload                              --
----------------------------------------------------------------------

local configPaths = { '/config', '/init.lua', '/custom.lua' }

reloadWatchers = {}

for _, configPath in ipairs(configPaths) do
  reloadWatchers[#reloadWatchers + 1] = hs.pathwatcher
    .new(hs.configdir .. configPath, function(paths)
      print('Reloading for ' .. table.concat(paths, ', '))
      hs.reload()
    end)
    :start()
end

hotkeyStore.register('Reload', 'Reload Configuration', MEH, 'r', hs.reload)

----------------------------------------------------------------------
--                             Hotkeys                              --
----------------------------------------------------------------------

-- Application launcher
local appKeyMods = { 'option', 'control' }
local appKeys = fnutils.mergeTables({
  m = 'Spotify',
  n = 'Notes',
  t = 'kitty',
}, CUSTOM.appKeys or {})

for key, app in pairs(appKeys) do
  hotkeyStore.register('Application Launchers', 'Open ' .. app, appKeyMods, key, function()
    hs.application.launchOrFocus(app)
  end)
end

-- Window switcher
local registerWindowSwitcherHotKey = hotkeyStore.registerGroup('Window Switcher')
registerWindowSwitcherHotKey('Next window', appKeyMods, 'tab', hs.window.switcher.nextWindow)
registerWindowSwitcherHotKey('Previous window', MEH, 'tab', hs.window.switcher.previousWindow)

-- Hotkey store
hotkeyStore.register('Hotkeys', 'Show hotkeys alert', MEH, 'm', hotkeyStore.show)

----------------------------------------------------------------------
--                        Window Management                         --
----------------------------------------------------------------------

hs.window.setShadows(false)
hs.window.animationDuration = 0

twm = require('config.twm')

twm.start()
hs.shutdownCallback = function()
  twm.stop()
end

local registerTwmHotkey = hotkeyStore.registerGroup('TWM')

registerTwmHotkey('Reset tiling', HYPER, 'r', twm.reset)
registerTwmHotkey('Tile', MEH, 't', twm.tile)

registerTwmHotkey('Toggle float', MEH, 'f', twm.toggleFloat)
registerTwmHotkey('Show layout', MEH, 'p', twm.showLayout)
registerTwmHotkey('Choose layout', MEH, 'c', twm.chooseLayout)

registerTwmHotkey('Focus window west', MEH, 'h', twm.focusWindowWest)
registerTwmHotkey('Focus window south', MEH, 'j', twm.focusWindowSouth)
registerTwmHotkey('Focus window north', MEH, 'k', twm.focusWindowNorth)
registerTwmHotkey('Focus window east', MEH, 'l', twm.focusWindowEast)

registerTwmHotkey('Swap window west', HYPER, 'h', twm.swapWindowWest)
registerTwmHotkey('Swap window south', HYPER, 'j', twm.swapWindowSouth)
registerTwmHotkey('Swap window north', HYPER, 'k', twm.swapWindowNorth)
registerTwmHotkey('Swap window north', HYPER, 'l', twm.swapWindowEast)

for i = 1, 9, 1 do
  registerTwmHotkey('Move window to space ' .. i, MEH, tostring(i), twm.moveWindowToSpace(i))
end

registerTwmHotkey('Set layout to floating', HYPER, 'f', function()
  twm.setLayout('floating')
end)
registerTwmHotkey('Set layout to tall or monocle', MEH, 's', function()
  local currentLayout = twm.getLayout()
  twm.setLayout(currentLayout == 'monocle' and 'tall' or 'monocle')
end)

----------------------------------------------------------------------
--                        Dark Mode Triggers                        --
----------------------------------------------------------------------

darkModeNotification = hs.distributednotifications.new(function()
  require('config.darkMode').configureSystemColors()
end, 'AppleInterfaceThemeChangedNotification')

darkModeNotification:start()

----------------------------------------------------------------------
--                      Spotify Notifications                       --
----------------------------------------------------------------------

hotkeyStore.register('Spotify', 'Show currently playing song', HYPER, 's', hs.spotify.displayCurrentTrack)
spotifyNotification = hs.distributednotifications.new(function()
  if hs.spotify.isPlaying() then
    hs.notify
      .new(function()
        hs.application.open('Spotify')
      end, {
        title = hs.spotify.getCurrentTrack(),
        subTitle = hs.spotify.getCurrentArtist(),
        informativeText = hs.spotify.getCurrentAlbum(),
        contentImage = hs.image.imageFromURL(hs.spotify.getCurrentTrackArtworkURL()),
      })
      :send()
  end
end, 'com.spotify.client.PlaybackStateChanged')

spotifyNotification:start()

----------------------------------------------------------------------
--                               Misc                               --
----------------------------------------------------------------------

require('hs.ipc').cliInstall(BREW_PREFIX) -- Enables CLI
hotkeyStore.verify()

hs.alert.show('Loaded HammerSpoon config')
