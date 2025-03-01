local hotkeyStore = require('hotkeyStore')
local twmUtils = require('twm.utils')

local HOTKEY_GROUP = 'Window Management'

local M = {}

---Register hotkeys for provided tiling window manager
---@param twm TilingWindowManager
function M.register(twm)
  local twmRegister = hotkeyStore.registerGroup(HOTKEY_GROUP)

  twmRegister('Toggle fullscreen for active space or window', MEH, 'f', function()
    local focusedWindow = hs.window.focusedWindow()

    if not focusedWindow then
      return
    end

    local workspace = twm:getWindowWorkspace(focusedWindow)

    if workspace then
      workspace:toggleFullscreen()
    else
      twmUtils.setWindowFrame(focusedWindow, twmUtils.getPaddedScreenFrame(focusedWindow:screen()))
    end
  end)

  local numWorkspaces = math.min(9, twm:getWorkspaceCount())

  for workspaceId = 1, numWorkspaces do
    twmRegister('Switch to workspace ' .. workspaceId, { 'ctrl' }, tostring(workspaceId), function()
      twm:switchToWorkspace(workspaceId)
    end)
  end

  for workspaceId = 1, numWorkspaces do
    twmRegister('Move window to workspace ' .. workspaceId, MEH, tostring(workspaceId), function()
      local focusedWindow = hs.window.focusedWindow()
      assert(focusedWindow)

      twm:removeWindow(focusedWindow)
      twm:addWindow(focusedWindow, workspaceId)
    end)
  end

  local keyDirectionMap = { h = 'West', j = 'South', k = 'North', l = 'East' }

  for key, direction in pairs(keyDirectionMap) do
    twmRegister('Focus window ' .. direction:lower(), MEH, key, function()
      local focusedWindow = hs.window.focusedWindow()
      focusedWindow['focusWindow' .. direction](focusedWindow, twm:getVisibleWindows(), nil, true)
    end)
  end

  for key, direction in pairs(keyDirectionMap) do
    twmRegister('Move window to ' .. direction:lower(), HYPER, key, function()
      local focusedWindow = hs.window.focusedWindow()
      assert(focusedWindow)

      local workspace = twm:getWindowWorkspace(focusedWindow)

      if not workspace then
        return
      end

      local windowsInDirection =
        focusedWindow['windowsTo' .. direction](focusedWindow, workspace:getWindows(), nil, true)

      if #windowsInDirection > 0 then
        workspace:swapWindows(focusedWindow, windowsInDirection[1])
      end
    end)
  end
end

function M.unregister()
  hotkeyStore.unregisterGroup(HOTKEY_GROUP)
end

return M
