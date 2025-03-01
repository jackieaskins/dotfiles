local M = {}

---Ensure each monitor only has one space
function M.removeExtraSpaces()
  ---@type table<string, string[]>
  local spaceIdsByScreen = hs.spaces.allSpaces()

  for _, spaceIds in pairs(spaceIdsByScreen) do
    if #spaceIds > 1 then
      for i = #spaceIds, 2, -1 do
        hs.spaces.removeSpace(spaceIds[i], false)
      end
    end
  end

  hs.spaces.closeMissionControl()
end

---Set window frame with workaround for applications with AXEnhancedUserInterface
---@param window hs.window
---@param frame hs.geometry
function M.setWindowFrame(window, frame)
  -- https://github.com/Hammerspoon/hammerspoon/issues/3224#issuecomment-1294359070

  ---@class hs.axuielement
  local appElement = hs.axuielement.applicationElement(window:application())
  local isEnhanced = appElement.AXEnhancedUserInterface

  if isEnhanced then
    appElement.AXEnhancedUserInterface = false
  end

  window:setFrame(frame)

  if isEnhanced then
    appElement.AXEnhancedUserInterface = true
  end
end

---Get a screen's frame with padding
---@param screen hs.screen
---@return hs.geometry
function M.getPaddedScreenFrame(screen)
  local screenFrame = screen:frame()
  local screenPadding = 14

  return hs.geometry.rect(
    screenFrame.x + screenPadding,
    screenFrame.y + screenPadding,
    screenFrame.w - (screenPadding * 2),
    screenFrame.h - (screenPadding * 2)
  )
end

return M
