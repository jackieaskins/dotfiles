----------------------------------------------------------------------
--                            Constants                             --
----------------------------------------------------------------------
BREW_PREFIX = '/opt/homebrew'
YABAI_PATH = BREW_PREFIX .. '/bin/yabai'
SKETCHYBAR_PATH = BREW_PREFIX .. '/bin/sketchybar'

MEH = { 'option', 'shift', 'ctrl' }
HYPER = { 'option', 'shift', 'ctrl', 'cmd' }

WF = hs.window.filter

----------------------------------------------------------------------
--                              Spoons                              --
----------------------------------------------------------------------
hs.loadSpoon('SpoonInstall')

spoon.SpoonInstall:andUse('EmmyLua')

spoon.SpoonInstall:andUse('ReloadConfiguration')
spoon.ReloadConfiguration:start()
spoon.ReloadConfiguration:bindHotkeys({
  reloadConfiguration = { HYPER, 'r' },
})

----------------------------------------------------------------------
--                            Stackline                             --
----------------------------------------------------------------------
Stackline = require('stackline')
local conf = hs.fnutils.copy(require('stackline.conf'))
conf.paths.yabai = YABAI_PATH
conf.appearance.showIcons = false
conf.appearance.pillThinness = 6
conf.appearance.offset.y = 6
conf.appearance.offset.x = 8
Stackline:init(conf)

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
  hs.hotkey.bind({ 'option', 'ctrl' }, key, function()
    hs.application.launchOrFocus(app)
  end)
end

hs.hotkey.bind(MEH, 'o', hs.window.switcher.nextWindow)

----------------------------------------------------------------------
--                               Misc                               --
----------------------------------------------------------------------
require('hs.ipc').cliInstall(BREW_PREFIX) -- Enables CLI
require('sketchybar')
require('yabai')

hs.alert.show('Loaded HammerSpoon config')
