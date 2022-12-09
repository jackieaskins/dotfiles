return hs.window.filter
  .new()
  :setDefaultFilter()
  :setOverrideFilter({
    allowRoles = { 'AXStandardWindow' },
    visible = true,
  })
  :setFilters({
    ['System Settings'] = false,
    ['Brave Browser'] = { rejectTitles = 'Picture in Picture' },
    ['Google Chrome'] = { rejectTitles = 'Picture in Picture' },
    ['Hammerspoon'] = { rejectTitles = 'Hammerspoon Console' },
  })
