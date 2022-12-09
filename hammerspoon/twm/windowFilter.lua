return hs.window.filter
  .new()
  :setDefaultFilter()
  :setOverrideFilter({
    allowRoles = { 'AXStandardWindow' },
    visible = true,
  })
  :setFilters({
    godot = false,
    Godot = false,
    ['System Settings'] = false,
    ['Brave Browser'] = { rejectTitles = 'Picture in Picture' },
    ['Google Chrome'] = { rejectTitles = 'Picture in Picture' },
    ['Hammerspoon'] = { rejectTitles = 'Hammerspoon Console' },
  })
