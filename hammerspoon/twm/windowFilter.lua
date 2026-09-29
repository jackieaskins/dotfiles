local appFilters = fnutils.mergeTables({
  [''] = false,
  ['Control Center'] = false,
  coreautha = false,
  FaceTime = false,
  Finder = false,
  ['Font Book'] = false,
  Home = false,
  Installer = false,
  ['iPhone Mirroring'] = false,
  ['Karabiner-Elements'] = false,
  KeyCastr = false,
  ['Keychain Access'] = false,
  LogiTune = false,
  Music = false,
  Notes = false,
  Passwords = false,
  Photos = false,
  Rocket = false,
  SecurityAgent = false,
  Simulator = false,
  Steam = false,
  ['System Settings'] = false,
  TV = false,
  Vorssaint = false,
  ['Zoom Workplace'] = false,
  ['zoom.us'] = false,
}, CUSTOM.twmWindowFilters or {})

local overrideFilter = {
  visible = true,
  hasTitlebar = true,
  rejectTitles = {
    '^Accessibility Access$',
    '^Picture.in.Picture$',
    '^Software Update$',
    '^Updating .+',
    '^Verification Code$',
    '^iCloud Passwords$',
  },
  allowRoles = { 'AXStandardWindow' },
}

return hs.window.filter.new():setOverrideFilter(overrideFilter):setFilters(appFilters)
