local appFilters = {
  [''] = false,
  Alcove = false,
  BetterDisplay = false,
  coreautha = false,
  Electron = false,
  FaceTime = false,
  Finder = false,
  Flux = false,
  ['Font Book'] = false,
  Home = false,
  Homerow = false,
  Ice = false,
  Installer = false,
  ['iPhone Mirroring'] = false,
  ['Karabiner-Elements'] = false,
  ['Keychain Access'] = false,
  Latest = false,
  MonitorControl = false,
  Music = false,
  Notes = false,
  Passwords = false,
  Photos = false,
  ProNotes = false,
  Raycast = false,
  Rocket = false,
  SecurityAgent = false,
  Steam = false,
  ['System Settings'] = false,
}

return hs.window.filter
  .new()
  :setOverrideFilter({
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
  })
  :setFilters(appFilters)
