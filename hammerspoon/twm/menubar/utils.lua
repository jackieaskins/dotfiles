local appImageCache = {}

local menubarWF = hs.window.filter.new():setOverrideFilter({
  allowRoles = { 'AXStandardWindow' },
})
local menubarCurrentWF = hs.window.filter.copy(menubarWF):setCurrentSpace(true)

---@param bundleID string | nil
---@return hs.image | nil
local function getAppImage(bundleID)
  if not bundleID then
    return nil
  end

  if appImageCache[bundleID] then
    return appImageCache[bundleID]
  end

  ---@type hs.image | nil
  local image = hs.image.imageFromAppBundle(bundleID)

  if image then
    local resizedImage = image:setSize({ h = 16, w = 16 })
    appImageCache[bundleID] = resizedImage
    return resizedImage
  end
end

---@return table<string, hs.window[]>
local function getWindowsBySpaceId()
  local windows = menubarWF:getWindows()

  ---@type table<string, hs.window[]>
  local windowsBySpaceId = {}

  for _, window in ipairs(windows) do
    local spaceIds = hs.spaces.windowSpaces(window) or {}

    for _, spaceId in ipairs(spaceIds) do
      local spaceWindows = windowsBySpaceId[spaceId] or {}
      table.insert(spaceWindows, window)
      windowsBySpaceId[spaceId] = spaceWindows
    end
  end

  return windowsBySpaceId
end

---@param window hs.window
---@return string
local function getWindowDisplayName(window)
  local windowDisplay = {}

  local app = window:application()
  if app and app:title() then
    table.insert(windowDisplay, app:title())
  end

  if window:title() then
    table.insert(windowDisplay, window:title())
  end

  return table.concat(windowDisplay, ' │ ')
end

local M = {
  menubarWF = menubarWF,
  menubarCurrentWF = menubarCurrentWF,
}

function M.getMenu()
  local menu = {}
  local nextWindowShortcut = 0
  local nextSpaceIndex = 1
  local windowsBySpaceId = getWindowsBySpaceId()
  local focusedWindow = hs.window.focusedWindow()

  ---@type hs.screen[]
  local screens = hs.screen.allScreens() or {}

  ---@type table<string, string[]>
  local allSpaces = hs.spaces.allSpaces() or {}
  for i, screen in ipairs(screens) do
    local screenUUID = screen:getUUID()
    table.insert(menu, { title = screen:name(), disabled = true })

    local spaceIds = allSpaces[screenUUID] or {}
    for _, spaceId in ipairs(spaceIds) do
      local spaceType = hs.spaces.spaceType(spaceId)

      local title = nil
      if spaceType == 'user' then
        title = 'Desktop ' .. tostring(nextSpaceIndex)
        nextSpaceIndex = nextSpaceIndex + 1
      elseif spaceType == 'fullscreen' then
        title = 'Fullscreen'
      end

      if title then
        table.insert(menu, {
          indent = 1,
          title = title,
          disabled = true,
        })

        local windows = windowsBySpaceId[spaceId] or {}
        for _, window in ipairs(windows) do
          local isFocused = window == focusedWindow
          ---@type hs.application | nil
          local application = window:application()
          local bundleID = application and application:bundleID()

          table.insert(menu, {
            indent = 2,
            title = getWindowDisplayName(window),
            image = getAppImage(bundleID),
            checked = isFocused,
            disabled = isFocused,
            shortcut = not isFocused and nextWindowShortcut < 10 and tostring(nextWindowShortcut) or nil,
            fn = function()
              window:focus()
            end,
          })

          if not isFocused then
            nextWindowShortcut = nextWindowShortcut + 1
          end
        end
      end
    end

    if i < #screens then
      table.insert(menu, { title = '-' })
    end
  end

  return menu
end

return M
