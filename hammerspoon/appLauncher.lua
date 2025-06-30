appLauncher = require('hotkeyStore').registerMode('Application Launcher', MEH, 'a')

local fnutils = require('fnutils')
local appKeys = fnutils.mergeTables({
  m = 'com.apple.Music',
  n = 'com.apple.Notes',
  t = 'com.github.wez.wezterm',
}, CUSTOM.appKeys or {})

for key, bundleID in pairs(appKeys) do
  appLauncher:bind('', key, function()
    hs.application.launchOrFocusByBundleID(bundleID)
    appLauncher:exit()
  end)

  appLauncher:bind('shift', key, function()
    hs.application.launchOrFocusByBundleID(bundleID)
  end)
end

appLauncher:bind('', 'escape', function()
  appLauncher:exit()
end)

function appLauncher:entered()
  hs.alert.closeAll()

  local alertText = { 'Launch Application:' }

  for key, bundleID in pairs(appKeys) do
    table.insert(alertText, key .. ' - ' .. hs.application.nameForBundleID(bundleID))
  end

  hs.alert.show(
    hs.styledtext.new(table.concat(alertText, '\n'), {
      font = { name = 'Mononoki Nerd Font Mono', size = 24 },
      color = { white = 1 },
    }),
    'persist'
  )
end

function appLauncher:exited()
  hs.alert.closeAll()
end
