BORDER_SIZE = 1.0
BORDER_RADIUS = 10.0
FOCUSED_WINDOW_BORDER = nil

FILE_WATCHER = hs.window.filter
  .new()
  :setOverrideFilter({
    allowRoles = { 'AXStandardWindow' },
  })
  :setFilters({
    Alfred = { rejectTitles = '' }, -- Ignore Alfred launcher
  })

local function addFocusedWindowBorder()
  if FOCUSED_WINDOW_BORDER ~= nil then
    FOCUSED_WINDOW_BORDER:delete()
    FOCUSED_WINDOW_BORDER = nil
  end

  local focusedWindow = hs.window.focusedWindow()

  if not focusedWindow then
    return
  end

  local activeScreenFrame = focusedWindow:screen():fullFrame()
  local focusedWindowFrame = focusedWindow:frame()

  if focusedWindow:isFullScreen() or focusedWindow:title() == 'Picture in Picture' then
    return
  end

  FOCUSED_WINDOW_BORDER = hs.canvas
    .new({
      x = activeScreenFrame.x,
      y = activeScreenFrame.y,
      h = activeScreenFrame.h,
      w = activeScreenFrame.w,
    })
    :appendElements({
      action = 'stroke',
      frame = {
        x = focusedWindowFrame.x,
        y = focusedWindowFrame.y,
        h = focusedWindowFrame.h,
        w = focusedWindowFrame.w,
      },
      roundedRectRadii = { xRadius = BORDER_RADIUS, yRadius = BORDER_RADIUS },
      strokeColor = hs.drawing.color.asRGB({ hex = '#A6DA95', alpha = 1 }),
      strokeWidth = BORDER_SIZE,
      type = 'rectangle',
    })
    :level(1)
    :show()
end

addFocusedWindowBorder()

FILE_WATCHER:subscribe({
  hs.window.filter.windowFocused,
  hs.window.filter.windowMoved,
  hs.window.filter.windowsChanged,
  hs.window.filter.windowDestroyed,
}, addFocusedWindowBorder)
