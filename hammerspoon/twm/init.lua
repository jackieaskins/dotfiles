local TilingWindowManager = require('twm.TilingWindowManager')
local fnutils = require('fnutils')

local function generateTilingWindowManager()
  local screens = hs.screen.allScreens()

  for _, twmConfiguration in ipairs(CUSTOM.twmMonitorConfigurations) do
    if #screens == #fnutils.getKeys(twmConfiguration) then
      local configurationHasEveryScreen = hs.fnutils.every(screens, function(screen)
        return twmConfiguration[screen:getUUID()] ~= nil
      end)

      if configurationHasEveryScreen then
        return TilingWindowManager.new(twmConfiguration)
      end
    end
  end

  local workspaces = {}
  for _, screen in ipairs(screens) do
    workspaces[screen:getUUID()] = { { layout = 'v_tiled', children = {} } }
  end
  return TilingWindowManager(workspaces)
end

twm = generateTilingWindowManager()

hs.screen.watcher
  .new(function()
    twm:destroy()
    twm = generateTilingWindowManager()
  end)
  :start()
