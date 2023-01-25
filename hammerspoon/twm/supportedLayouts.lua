local M = {}

---Floating
---@param windows hs.window[]
---@param screenFrame hs.geometry
function M.floating(windows, screenFrame) end

---Monocle
---@param windows hs.window[]
---@param screenFrame hs.geometry
function M.monocle(windows, screenFrame)
  for _, window in pairs(windows) do
    window:setFrame({
      x = screenFrame.x,
      y = screenFrame.y,
      w = screenFrame.w,
      h = screenFrame.h,
    })
  end
end

---Tall
---@param windows hs.window[]
---@param screenFrame hs.geometry
function M.tall(windows, screenFrame)
  local winWidth = screenFrame.w / 2
  local winHeight = screenFrame.h / (#windows - 1)

  for index, window in ipairs(windows) do
    if index == 1 then
      window:setFrame({
        x = screenFrame.x,
        y = screenFrame.y,
        w = winWidth,
        h = screenFrame.h,
      })
    else
      window:setFrame({
        x = screenFrame.x + winWidth,
        y = screenFrame.y + ((index - 2) * winHeight),
        h = winHeight,
        w = winWidth,
      })
    end
  end
end

---Tall (Reversed)
---@param windows hs.window[]
---@param screenFrame hs.geometry
function M.rtall(windows, screenFrame)
  local winWidth = screenFrame.w / 2
  local winHeight = screenFrame.h / (#windows - 1)

  for index, window in ipairs(windows) do
    if index == 1 then
      window:setFrame({
        x = screenFrame.x + winWidth,
        y = screenFrame.y,
        w = winWidth,
        h = screenFrame.h,
      })
    else
      window:setFrame({
        x = screenFrame.x,
        y = screenFrame.y + ((index - 2) * winHeight),
        h = winHeight,
        w = winWidth,
      })
    end
  end
end

---Grid
---@param windows hs.window[]
---@param screenFrame hs.geometry
function M.grid(windows, screenFrame)
  if #windows <= 2 then
    return M.tall(windows, screenFrame)
  end

  local numRows = math.ceil(math.sqrt(#windows))
  local numCols = math.ceil(#windows / numRows)

  local winHeight = screenFrame.h / numRows
  local winWidth = screenFrame.w / numCols

  for index, window in ipairs(windows) do
    local x = screenFrame.x + math.floor((index - 1) / numRows) * winWidth
    local y = screenFrame.y + ((index - 1) % numRows) * winHeight

    window:setFrame({
      x = x,
      y = y,
      -- Make last window fill remaining height
      h = index == #windows and (screenFrame.y + screenFrame.h) - y or winHeight,
      w = winWidth,
    })
  end
end

return M
