local fnutils = require('fnutils')

local appFilters = fnutils.mergeTables({
  [''] = false,
  ['Alfred Preferences'] = false,
  AltTab = false,
  BetterDisplay = false,
  FaceTime = false,
  Finder = false,
  Flux = false,
  ['Folder Hub'] = false,
  ['Font Book'] = false,
  Home = false,
  Ice = false,
  ['iPhone Mirroring'] = false,
  ['Karabiner-Elements'] = false,
  ['Keychain Access'] = false,
  MonitorControl = false,
  Notes = false,
  Passwords = false,
  Raycast = false,
  Steam = false,
  ['System Settings'] = false,
}, CUSTOM.twmWindowFilters or {})

local windowFilter = hs.window.filter
  .new()
  :setOverrideFilter({
    visible = true,
    hasTitlebar = true,
    rejectTitles = { 'Picture.in.Picture' },
    allowRoles = { 'AXStandardWindow' },
  })
  :setFilters(appFilters)

---Determine if window is on one space and optionally if it is on provided space
---@param window hs.window
---@param spaceId? number
---@return boolean
local function isWindowOnOneSpace(window, spaceId)
  local windowSpaces = hs.spaces.windowSpaces(window) or {}

  if spaceId then
    return #windowSpaces == 1 and windowSpaces[1] == spaceId
  end

  return #windowSpaces == 1
end

---Get first window in direction
---@param getWindowsFn 'windowsToWest' | 'windowsToEast' | 'windowsToNorth' | 'windowsToSouth'
---@param window hs.window
---@param spaceId? number
---@return hs.window | nil
local function windowInDir(getWindowsFn, window, spaceId)
  local windows = windowFilter[getWindowsFn](windowFilter, window, false, true)

  return hs.fnutils.find(windows, function(w)
    return isWindowOnOneSpace(w, spaceId)
  end)
end

local M = {}

---Get windows currently in the window filter, optionally on a specified space
---@param spaceId? number
---@return hs.window[]
function M.getWindows(spaceId)
  return hs.fnutils.filter(windowFilter:getWindows(), function(window)
    return isWindowOnOneSpace(window, spaceId)
  end) or {}
end

function M.windowToWest(window, spaceId)
  return windowInDir('windowsToWest', window, spaceId)
end

function M.windowToSouth(window, spaceId)
  return windowInDir('windowsToSouth', window, spaceId)
end

function M.windowToNorth(window, spaceId)
  return windowInDir('windowsToNorth', window, spaceId)
end

function M.windowToEast(window, spaceId)
  return windowInDir('windowsToEast', window, spaceId)
end

---@alias WFCallback fun(window: hs.window, appName: string, event: string)

---Subscribe to window filter event(s)
---@param events string | string[] | { [string]: WFCallback }
---@param callback WFCallback
---@param immediate? boolean
function M.subscribe(events, callback, immediate)
  windowFilter:subscribe(events, callback, immediate)
end

function M.unsubscribeAll()
  windowFilter:unsubscribeAll()
end

---Determine if a provided window is allowed, optionally by space
---@param window hs.window
---@param spaceId? number
---@return boolean
function M.isWindowAllowed(window, spaceId)
  return hs.fnutils.some(M.getWindows(spaceId), function(w)
    return window == w
  end)
end

return M
