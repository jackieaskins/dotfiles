local mergeTables = require('config.fnutils').mergeTables

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
  ['System Preferences'] = false,
  ['System Settings'] = false,
  FaceTime = false,
  Finder = false,
  ['Font Book'] = false,
  Ice = false,
  ['iPhone Mirroring'] = false,
  ['Karabiner-Elements'] = false,
  ['Keychain Access'] = false,
  Notes = false,
  Passwords = false,
  Raycast = false,
}, CUSTOM.twmWindowFilters or {})

return hs.window.filter.new(windowFilters)
