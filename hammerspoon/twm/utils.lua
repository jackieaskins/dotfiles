local M = {}

---@param window hs.window
---@param frame hs.geometry
---Set window frame with workaround for applications with AXEnhancedUserInterface
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

return M
