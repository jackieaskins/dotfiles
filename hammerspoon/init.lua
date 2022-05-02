local BREW_PREFIX = '/opt/homebrew'
local YABAI_PATH = BREW_PREFIX .. '/bin/yabai'
local MEH = { 'option', 'shift', 'ctrl' }
local HYPER = { 'option', 'shift', 'ctrl', 'cmd' }

require('hs.ipc').cliInstall(BREW_PREFIX)

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

hs.spaces.watcher.new(focus_window):start()

hs.window.filter.new():subscribe({
  hs.window.filter.windowMinimized,
  hs.window.filter.windowHidden,
  hs.window.filter.windowDestroyed,
}, focus_window)

----------------------------------------------------------------------
--                             Keymaps                              --
----------------------------------------------------------------------
hs.hotkey.bind(MEH, 'r', 'Reloading Yabai', function()
  os.execute('launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"')
end)

local function yabai(args, stream_cb, cb)
  return function()
    hs.task.new(YABAI_PATH, cb, stream_cb or function()
      return true
    end, args):start()
  end
end

hs.hotkey.bind(MEH, 'f', yabai({ '-m', 'window', '--toggle', 'zoom-fullscreen' }))
hs.hotkey.bind(MEH, 'p', yabai({ '-m', 'window', '--toggle', 'zoom-parent' }))

for key, direction in pairs({ h = 'west', j = 'south', k = 'north', l = 'east' }) do
  hs.hotkey.bind(MEH, key, yabai({ '-m', 'window', '--warp', direction }))
  hs.hotkey.bind(
    HYPER,
    key,
    yabai({ '-m', 'window', '--focus', direction }, function(_, _, stderr)
      if stderr ~= '' then
        yabai({ '-m', 'display', '--focus', direction })()
      end
      return true
    end)
  )
end

for key, direction in pairs({ left = 'prev', right = 'next' }) do
  hs.hotkey.bind(
    MEH,
    key,
    yabai({ '-m', 'window', '--space', direction }, nil, function(_, _, stderr)
      if stderr == '' then
        -- Adding fn as a workaround for this issue: https://github.com/Hammerspoon/hammerspoon/issues/1946
        hs.eventtap.keyStroke({ 'fn', 'ctrl' }, key, 100)
      end
    end)
  )
  hs.hotkey.bind(
    HYPER,
    key,
    yabai({ '-m', 'window', '--display', direction }, nil, yabai({ '-m', 'display', '--focus', direction }))
  )
end

for idx = 1, 9 do
  local str_idx = tostring(idx)
  hs.hotkey.bind(
    MEH,
    str_idx,
    yabai({ '-m', 'window', '--space', str_idx }, nil, function()
      hs.eventtap.keyStroke({ 'ctrl' }, str_idx, 100)
    end)
  )
  hs.hotkey.bind(
    HYPER,
    str_idx,
    yabai({ '-m', 'window', '--display', str_idx }, nil, yabai({ '-m', 'display', '--focus', str_idx }))
  )
end

hs.alert.show('Loaded HammerSpoon config')
