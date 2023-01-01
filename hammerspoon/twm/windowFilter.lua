local mergeTables = require('utils').mergeTables

local window_filters = mergeTables({
  ['System Preferences'] = false,
  ['System Settings'] = false,
  ['Brave Browser'] = { rejectTitles = 'Picture in Picture' },
  ['Google Chrome'] = { rejectTitles = 'Picture in Picture' },
  ['Hammerspoon'] = { rejectTitles = 'Hammerspoon Console' },
}, CUSTOM.twm_window_filters or {})

return hs.window.filter
  .new()
  :setDefaultFilter()
  :setOverrideFilter({
    allowRoles = { 'AXStandardWindow' },
    visible = true,
  })
  :setFilters(window_filters)
