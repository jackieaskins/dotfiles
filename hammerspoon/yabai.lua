----------------------------------------------------------------------
--                             Helpers                              --
----------------------------------------------------------------------
local function yabai(args, stream_cb, cb)
  return function()
    hs.task.new(YABAI_PATH, cb, stream_cb or function()
      return true
    end, args):start()
  end
end

local function with_current_layout(cb)
  return yabai({ '-m', 'query', '--spaces', '--space' }, function(_, stdout)
    local current_layout = hs.json.decode(stdout).type
    cb(current_layout)
    return true
  end)
end

----------------------------------------------------------------------
--                              Reload                              --
----------------------------------------------------------------------
hs.hotkey.bind(MEH, 'r', 'Reloading Yabai', function()
  os.execute('launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"')
end)

----------------------------------------------------------------------
--                             Toggles                              --
----------------------------------------------------------------------
hs.hotkey.bind(MEH, 'f', yabai({ '-m', 'window', '--toggle', 'zoom-fullscreen' }))
hs.hotkey.bind(MEH, 'p', yabai({ '-m', 'window', '--toggle', 'zoom-parent' }))
hs.hotkey.bind(
  MEH,
  's',
  with_current_layout(function(current_layout)
    yabai({ '-m', 'space', '--layout', current_layout == 'bsp' and 'stack' or 'bsp' })()
    local stack_left_padding = tostring(
      Stackline.config:get('appearance.offset.x') * 2 + Stackline.config:get('appearance.size')
    )
    yabai({ '-m', 'config', 'left_padding', current_layout == 'bsp' and stack_left_padding or '6' })()
  end)
)

----------------------------------------------------------------------
--                        Window Management                         --
----------------------------------------------------------------------
for key, val in pairs({
  h = { 'west', 'stack.prev' },
  j = { 'south', 'stack.next' },
  k = { 'north', 'stack.prev' },
  l = { 'east', 'stack.next' },
}) do
  local win_dir, stack_dir = val[1], val[2]

  hs.hotkey.bind(MEH, key, yabai({ '-m', 'window', '--warp', win_dir }))
  hs.hotkey.bind(
    HYPER,
    key,
    with_current_layout(function(current_layout)
      if current_layout == 'bsp' then
        yabai({ '-m', 'window', '--focus', win_dir }, function(_, _, stderr)
          -- If there is no window on current display in direction, move to next display
          if stderr ~= '' then
            yabai({ '-m', 'display', '--focus', win_dir })()
          end
          return true
        end)()
      else
        yabai({ '-m', 'window', '--focus', stack_dir }, function(_, _, stderr)
          -- If cannot move to prev/next stack go to last/first, respectively
          if stderr ~= '' then
            yabai({ '-m', 'window', '--focus', stack_dir == 'stack.next' and 'stack.first' or 'stack.last' })()
          end
          return true
        end)()
      end
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
