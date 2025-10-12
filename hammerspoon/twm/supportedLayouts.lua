---@class ScreenFrame
---@field x number
---@field y number
---@field w number
---@field h number

---@alias Layout fun(windows: hs.window[], screenFrame: ScreenFrame, gap: number)

local twmUtils = require('twm.utils')
local stackGap = CUSTOM.twmStackGap or 15

---@param screenFrame ScreenFrame
---@param gap number
---@param numCols number
---@return number
local function getWinWidth(screenFrame, gap, numCols)
  -- Total width of the screen
  -- Minus the number of vertical gaps (one less than the number of columns)
  -- Evenly shared between each column
  return (screenFrame.w - (gap * (numCols - 1))) / numCols
end

---@param screenFrame ScreenFrame
---@param gap number
---@param numRows number
---@return number
local function getWinHeight(screenFrame, gap, numRows)
  -- Total height of the screen
  -- Minus the number of horizontal gaps (one less than the number of rows)
  -- evenly shared between each row
  return (screenFrame.h - (gap * (numRows - 1))) / numRows
end

local M = {}

---Floating
---@type Layout
function M.floating() end

---Stack
---@type Layout
function M.stack(windows, screenFrame)
  local winHeight = screenFrame.h - (stackGap * math.min(2, #windows - 1))

  for index, window in ipairs(windows) do
    local y
    if index == 1 then
      y = screenFrame.y
    elseif index == 2 or index ~= #windows then
      y = screenFrame.y + stackGap
    else
      y = screenFrame.y + (2 * stackGap)
    end

    twmUtils.setWindowFrame(window, {
      x = screenFrame.x,
      y = y,
      w = screenFrame.w,
      h = winHeight,
    })
  end
end

---Tall
---@type Layout
function M.tall(windows, screenFrame, gap)
  if #windows == 1 then
    return M.stack(windows, screenFrame, gap)
  end

  local winWidth = getWinWidth(screenFrame, gap, 2)
  local winHeight = getWinHeight(screenFrame, gap, #windows - 1)

  for index, window in ipairs(windows) do
    if index == 1 then
      twmUtils.setWindowFrame(window, {
        x = screenFrame.x,
        y = screenFrame.y,
        w = winWidth,
        h = screenFrame.h,
      })
    else
      twmUtils.setWindowFrame(window, {
        x = screenFrame.x + winWidth + gap,
        y = screenFrame.y + ((index - 2) * (winHeight + gap)),
        w = winWidth,
        h = winHeight,
      })
    end
  end
end

---Tall (Reversed)
---@type Layout
function M.rtall(windows, screenFrame, gap)
  if #windows == 1 then
    return M.stack(windows, screenFrame, gap)
  end

  local winWidth = getWinWidth(screenFrame, gap, 2)
  local winHeight = getWinHeight(screenFrame, gap, #windows - 1)

  for index, window in ipairs(windows) do
    if index == 1 then
      twmUtils.setWindowFrame(window, {
        x = screenFrame.x + winWidth + gap,
        y = screenFrame.y,
        w = winWidth,
        h = screenFrame.h,
      })
    else
      twmUtils.setWindowFrame(window, {
        x = screenFrame.x,
        y = screenFrame.y + ((index - 2) * (winHeight + gap)),
        h = winHeight,
        w = winWidth,
      })
    end
  end
end

---Grid
---@type Layout
function M.grid(windows, screenFrame, gap)
  if #windows <= 2 then
    return M.tall(windows, screenFrame, gap)
  end

  local numRows = math.ceil(math.sqrt(#windows))
  local numCols = math.ceil(#windows / numRows)

  local winWidth = getWinWidth(screenFrame, gap, numCols)
  local winHeight = getWinHeight(screenFrame, gap, numRows)

  for index, window in ipairs(windows) do
    local x = screenFrame.x + math.floor((index - 1) / numRows) * (winWidth + gap)
    local y = screenFrame.y + ((index - 1) % numRows) * (winHeight + gap)

    twmUtils.setWindowFrame(window, {
      x = x,
      y = y,
      -- Make last window fill remaining height
      h = index == #windows and screenFrame.y + screenFrame.h - y or winHeight,
      w = winWidth,
    })
  end
end

---Columns
---@type Layout
function M.columns(windows, screenFrame, gap)
  local winWidth = getWinWidth(screenFrame, gap, #windows)

  for index, window in ipairs(windows) do
    twmUtils.setWindowFrame(window, {
      x = screenFrame.x + (index - 1) * (winWidth + gap),
      y = screenFrame.y,
      w = winWidth,
      h = screenFrame.h,
    })
  end
end

---Rows
---@type Layout
function M.rows(windows, screenFrame, gap)
  local winHeight = getWinHeight(screenFrame, gap, #windows)

  for index, window in ipairs(windows) do
    twmUtils.setWindowFrame(window, {
      x = screenFrame.x,
      y = screenFrame.y + (index - 1) * (winHeight + gap),
      w = screenFrame.w,
      h = winHeight,
    })
  end
end

return M
