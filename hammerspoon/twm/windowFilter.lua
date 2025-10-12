local appFilters = fnutils.mergeTables({
  [''] = false,
  BetterDisplay = false,
  boringNotch = false,
  coreautha = false,
  FaceTime = false,
  Finder = false,
  ['Font Book'] = false,
  Home = false,
  Ice = false,
  Installer = false,
  ['iPhone Mirroring'] = false,
  ['Karabiner-Elements'] = false,
  KeyCastr = false,
  ['Keychain Access'] = false,
  MonitorControl = false,
  Notes = false,
  Passwords = false,
  Photos = false,
  Raycast = false,
  Rocket = false,
  SecurityAgent = false,
  Steam = false,
  ['System Settings'] = false,
  TV = false,
  ['Zoom Workplace'] = false,
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
