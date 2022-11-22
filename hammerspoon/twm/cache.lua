return {
  floatingWindows = {},
  spaceLayouts = {},
  spaceWindows = {},
  windowFilter = hs.window.filter
    .new()
    :setDefaultFilter()
    :setOverrideFilter({
      visible = true,
      fullscreen = false,
      allowRoles = { 'AXStandardWindow' },
    })
    :setFilters({
      ['Brave Browser'] = { rejectTitles = 'Picture in Picture' },
      ['Google Chrome'] = { rejectTitles = 'Picture in Picture' },
      ['Hammerspoon'] = { rejectTitles = 'Hammerspoon Console' },
    }),
}
