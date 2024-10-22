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
--                              Spoons                              --
----------------------------------------------------------------------

hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall:andUse('EmmyLua')
spoon.SpoonInstall:asyncUpdateAllRepos()

----------------------------------------------------------------------
--                              Reload                              --
----------------------------------------------------------------------

reloadWatcher = hs.pathwatcher.new(hs.configdir, function()
  -- TODO: Filter out paths that shouldn't trigger reload
  hs.reload()
end)
reloadWatcher:start()

hotkeyStore.register('Reload', 'Reload configuration', MEH, 'r', hs.reload)

----------------------------------------------------------------------
--                             Hotkeys                              --
----------------------------------------------------------------------

-- Application launcher
local appKeyMods = { 'option', 'control' }
local appKeys = fnutils.mergeTables({
  m = 'Spotify',
  n = 'Notes',
  t = 'WezTerm',
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

require('twm')

----------------------------------------------------------------------
--                            Dark Mode                             --
----------------------------------------------------------------------

darkModeNotification = hs.distributednotifications.new(function()
  require('darkMode').handleDarkModeChange()
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
