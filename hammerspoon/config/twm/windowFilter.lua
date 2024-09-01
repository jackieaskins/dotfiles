local mergeTables = require('config.fnutils').mergeTables

local windowFilters = mergeTables({
  [''] = false,
  ['Alfred Preferences'] = false,
  AltTab = false,
  BetterDisplay = false,
  ['System Preferences'] = false,
  ['System Settings'] = false,
  ['Brave Browser'] = { rejectTitles = 'Picture in Picture' },
  FaceTime = false,
  Finder = false,
  ['Google Chrome'] = { rejectTitles = 'Picture in Picture' },
  Hammerspoon = { rejectTitles = 'Hammerspoon Console' },
  Ice = false,
  ['Karabiner-Elements'] = false,
  ['Keychain Access'] = false,
  Raycast = false,
}, CUSTOM.twmWindowFilters or {})

return hs.window.filter
  .new()
  :setOverrideFilter({
    allowRoles = { 'AXStandardWindow' },
    visible = true,
  })
  :setFilters(windowFilters)
