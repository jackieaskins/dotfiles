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
local app_keys = {
  b = 'Brave Browser',
  i = 'Messages',
  m = 'Spotify',
  t = 'kitty',
}
for key, app in pairs(app_keys) do
  hs.hotkey.bind(MEH, key, function()
    hs.application.launchOrFocus(app)
  end)
end

hs.hotkey.bind(MEH, 'tab', hs.window.switcher.nextWindow)

----------------------------------------------------------------------
--                        Window Highlights                         --
----------------------------------------------------------------------
hs.window.highlight.ui.frameColor = hs.drawing.color.asRGB({ hex = '#A6DA95', alpha = 1 })
hs.window.highlight.ui.frameWidth = 2
hs.window.highlight.ui.overlayColor = { 0, 0, 0, 0.01 }
hs.window.highlight.ui.overlay = true

hs.window.highlight.start()

----------------------------------------------------------------------
--                               Misc                               --
----------------------------------------------------------------------
require('hs.ipc').cliInstall(BREW_PREFIX) -- Enables CLI

hs.alert.show('Loaded HammerSpoon config')
