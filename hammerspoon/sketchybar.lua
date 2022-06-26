----------------------------------------------------------------------
--                            Constants                             --
----------------------------------------------------------------------
DELAY = 0.2
FILE_WATCHER = WF.new():setAppFilter('Alfred', {
  rejectTitles = { '' }, -- Ignore Alfred launchbar
})

----------------------------------------------------------------------
--                              Utils                               --
----------------------------------------------------------------------
local function sketchybar(args, stream_cb, cb)
  hs.task.new(SKETCHYBAR_PATH, cb, stream_cb or function()
    return true
  end, args):start()
end
local function trigger_event(event, args)
  sketchybar(hs.fnutils.concat({ '--trigger', event }, args or {}))
end

----------------------------------------------------------------------
--                         Battery Watcher                          --
----------------------------------------------------------------------
BatteryWatcher = hs.battery.watcher.new(function()
  trigger_event('battery_change')
end):start()

----------------------------------------------------------------------
--                      Current Window Watcher                      --
----------------------------------------------------------------------
CurrentWindowChange = hs.timer.delayed.new(DELAY, function()
  trigger_event('current_window_change')
end)

local current_window_change_events = {
  WF.windowTitleChanged,
  WF.windowFocused,
  WF.windowUnfocused,
}

FileCurrentWindowWatchers = {}
for _, event in ipairs(current_window_change_events) do
  table.insert(
    FileCurrentWindowWatchers,
    FILE_WATCHER:subscribe(event, function()
      CurrentWindowChange:start()
    end)
  )
end

----------------------------------------------------------------------
--                          Space Watchers                          --
----------------------------------------------------------------------
AnySpaceChange = hs.timer.delayed.new(DELAY, function()
  trigger_event('any_space_change')
end)

local window_change_events = {
  WF.windowNotVisible,
  WF.windowVisible,
  WF.windowInCurrentSpace,
  WF.windowNotInCurrentSpace,
}

FileSpaceWatchers = {}
for _, event in ipairs(window_change_events) do
  table.insert(
    FileSpaceWatchers,
    FILE_WATCHER:subscribe(event, function()
      AnySpaceChange:start()
    end)
  )
end
SpaceChangeWatcher = hs.spaces.watcher.new(function()
  AnySpaceChange:start()
end):start()

----------------------------------------------------------------------
--                          Audio Watcher                           --
----------------------------------------------------------------------
AudioDeviceChange = hs.timer.delayed.new(DELAY, function()
  trigger_event('audiodevice_change')
end)

AudioWatcher = hs.audiodevice.watcher
AudioWatcher.setCallback(function()
  AudioDeviceChange:start()
end)
AudioWatcher.start()
