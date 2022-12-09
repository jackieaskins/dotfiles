----------------------------------------------------------------------
--                            Constants                             --
----------------------------------------------------------------------
BREW_PREFIX = '/opt/homebrew'

MEH = { 'option', 'shift', 'ctrl' }
HYPER = { 'option', 'shift', 'ctrl', 'cmd' }

----------------------------------------------------------------------
--                              Spoons                              --
----------------------------------------------------------------------
hs.loadSpoon('SpoonInstall')

spoon.SpoonInstall:andUse('EmmyLua')

spoon.SpoonInstall:andUse('ReloadConfiguration')
spoon.ReloadConfiguration:start()
spoon.ReloadConfiguration:bindHotkeys({
  reloadConfiguration = { MEH, 'r' },
})

----------------------------------------------------------------------
--                             Keymaps                              --
----------------------------------------------------------------------
for key, app in pairs({
  b = 'Brave Browser',
  g = 'Godot',
  i = 'Messages',
  m = 'Spotify',
  t = 'kitty',
}) do
  hs.hotkey.bind({ 'option', 'control' }, key, function()
    hs.application.launchOrFocus(app)
  end)
end

hs.hotkey.bind(MEH, 'tab', hs.window.switcher.nextWindow)

----------------------------------------------------------------------
--                        Window Management                         --
----------------------------------------------------------------------
hs.window.setShadows(false)
hs.window.animationDuration = 0

twm = require('twm')
twm.start()
hs.shutdownCallback = function()
  twm.stop()
end

hs.hotkey.bind(MEH, 'f', twm.toggleFloat)
hs.hotkey.bind(MEH, 'p', twm.showLayout)
hs.hotkey.bind(MEH, 'c', twm.chooseLayout)

hs.hotkey.bind(MEH, 'h', twm.focusWindowWest)
hs.hotkey.bind(MEH, 'j', twm.focusWindowSouth)
hs.hotkey.bind(MEH, 'k', twm.focusWindowNorth)
hs.hotkey.bind(MEH, 'l', twm.focusWindowEast)

hs.hotkey.bind(HYPER, 'h', twm.swapWindowWest)
hs.hotkey.bind(HYPER, 'j', twm.swapWindowSouth)
hs.hotkey.bind(HYPER, 'k', twm.swapWindowNorth)
hs.hotkey.bind(HYPER, 'l', twm.swapWindowEast)

hs.hotkey.bind(HYPER, 'f', function()
  twm.setLayout('floating')
end)
hs.hotkey.bind(MEH, 's', function()
  local currentLayout = twm.getLayout()
  twm.setLayout(currentLayout == 'monocle' and 'tall' or 'monocle')
end)

----------------------------------------------------------------------
--                      Spotify Notifications                       --
----------------------------------------------------------------------
hs.hotkey.bind(HYPER, 's', hs.spotify.displayCurrentTrack)
spotifyNotification = hs.distributednotifications.new(function()
  if hs.spotify.isPlaying() then
    hs.notify
      .new(function()
        hs.application.open('Spotify')
      end, {
        title = hs.spotify.getCurrentTrack(),
        subTitle = hs.spotify.getCurrentArtist(),
        informativeText = hs.spotify.getCurrentAlbum(),
      })
      :send()
  end
end, 'com.spotify.client.PlaybackStateChanged')

spotifyNotification:start()

----------------------------------------------------------------------
--                               Misc                               --
----------------------------------------------------------------------
require('hs.ipc').cliInstall(BREW_PREFIX) -- Enables CLI

hs.alert.show('Loaded HammerSpoon config')
