local mergeTables = require('fnutils').mergeTables

local windowFilters = mergeTables({
  default = {
    visible = true,
    hasTitlebar = true,
    rejectTitles = { 'Picture in Picture', 'Picture-in-Picture' },
    allowRoles = { 'AXStandardWindow' },
  },
  [''] = false,
  ['Alfred Preferences'] = false,
  AltTab = false,
  BetterDisplay = false,
  FaceTime = false,
  Finder = false,
  Flux = false,
  ['Font Book'] = false,
  Ice = false,
  ['iPhone Mirroring'] = false,
  ['Karabiner-Elements'] = false,
  ['Keychain Access'] = false,
  MonitorControl = false,
  Notes = false,
  Passwords = false,
  Raycast = false,
  ['System Settings'] = false,
}, CUSTOM.twmWindowFilters or {})

local baseWindowFilter = hs.window.filter.new(windowFilters)
return hs.window.filter.new(function(window)
  if not window then
    return false
  end

  local spaceCount = #hs.spaces.windowSpaces(window)
  return spaceCount == 1 and baseWindowFilter:isWindowAllowed(window)
end)
