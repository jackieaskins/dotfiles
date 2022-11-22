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

return M
