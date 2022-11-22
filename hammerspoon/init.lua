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

function setLayout(layout)
  return function()
    twm.setLayout(layout)
  end
end
hs.hotkey.bind(HYPER, 'f', setLayout('floating'))
hs.hotkey.bind(MEH, 's', setLayout('monocle'))
hs.hotkey.bind(HYPER, 's', setLayout('tall'))

require('windowBorder')

----------------------------------------------------------------------
--                               Misc                               --
----------------------------------------------------------------------
require('hs.ipc').cliInstall(BREW_PREFIX) -- Enables CLI

hs.alert.show('Loaded HammerSpoon config')
