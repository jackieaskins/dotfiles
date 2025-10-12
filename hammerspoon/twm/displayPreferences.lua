---@class SpacePreference
---@field layout string
---@field bundleIDs string[]
---@field focused? boolean

---@class DisplayPreference
---@field screenUUID string
---@field spaces SpacePreference[]

local M = {}

-- TODO: Validate saved preferences
function M.loadOrCreate()
  local savedPreferences = CUSTOM.twmDisplayPreferences or {}

  ---@type string[]
  local screenUUIDs = fnutils.imap(hs.spaces.data_managedDisplaySpaces(), function(display)
    return display['Display Identifier']
  end)

  local foundPreferences = hs.fnutils.find(savedPreferences, function(preferences)
    if #preferences ~= #screenUUIDs then
      return false
    end

    for index, screenUUID in ipairs(screenUUIDs) do
      if screenUUID ~= preferences[index].screenUUID then
        return false
      end
    end

    return true
  end)

  if foundPreferences then
    return foundPreferences
  end

  return fnutils.imap(screenUUIDs, function(screenUUID)
    ---@type DisplayPreference
    return {
      screenUUID = screenUUID,
      spaces = {
        { layout = 'tall', bundleIDs = {}, focused = true },
      },
    }
  end)
end

return M
