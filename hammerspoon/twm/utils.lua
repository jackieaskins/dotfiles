local M = {}

function M.getUserSpaceIdsByScreenId()
  local displays = hs.spaces.data_managedDisplaySpaces() or {}

  local userSpaceIdsByScreenId = {}

  for _, display in ipairs(displays) do
    local screenId = display['Display Identifier']
    local spaceIds = {}

    for _, space in ipairs(display.Spaces) do
      if space.type == 0 then
        table.insert(spaceIds, space.ManagedSpaceID)
      end
    end

    userSpaceIdsByScreenId[screenId] = spaceIds
  end

  return userSpaceIdsByScreenId
end

return M
