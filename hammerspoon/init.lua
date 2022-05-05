----------------------------------------------------------------------
--                            Constants                             --
----------------------------------------------------------------------
BREW_PREFIX = '/opt/homebrew'
YABAI_PATH = BREW_PREFIX .. '/bin/yabai'
MEH = { 'option', 'shift', 'ctrl' }
HYPER = { 'option', 'shift', 'ctrl', 'cmd' }

require('hs.ipc').cliInstall(BREW_PREFIX) -- Enables CLI

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
conf.appearance.offset.y = 6
conf.appearance.offset.x = 6
Stackline:init(conf)

----------------------------------------------------------------------
--                             Watchers                             --
----------------------------------------------------------------------
local unsupported_applications = {
  { name = 'Google Chrome', title = 'Picture in Picture' },
}

local function is_supported_window(window)
  return window
    and window:isVisible()
    and window:isStandard()
    and not hs.fnutils.find(unsupported_applications, function(app)
      return app.name == window:application():name() and app.title == window:title()
    end)
end

local function focus_window()
  local focused_window = hs.window.focusedWindow()
  local space_id = hs.spaces.focusedSpace()
  local spaces = hs.spaces.windowSpaces(focused_window or -1)

  if hs.fnutils.contains(spaces, space_id) and is_supported_window(focused_window) then
    return
  end

  hs.fnutils.find(
    hs.fnutils.map(hs.spaces.windowsForSpace(space_id), function(window_id)
      return hs.window.get(window_id)
    end),
    function(window)
      return is_supported_window(window)
    end
  ):focus()
end

SpacesWatcher = hs.spaces.watcher.new(focus_window):start()
WindowWatcher = hs.window.filter.new():subscribe({
  hs.window.filter.windowMinimized,
  hs.window.filter.windowHidden,
  hs.window.filter.windowDestroyed,
}, focus_window)

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

require('yabai')

hs.alert.show('Loaded HammerSpoon config')
