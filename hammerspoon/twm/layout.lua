local cache = require('twm.cache')
local supportedLayouts = require('twm.supportedLayouts')
local utils = require('twm.utils')

local M = {}

function M.list()
  local layoutNames = {}
  for layoutName, _ in pairs(supportedLayouts) do
    table.insert(layoutNames, layoutName)
  end
  return layoutNames
end

function M.show(spaceId)
  local space = spaceId or hs.spaces.focusedSpace()
  hs.alert.show('Layout: ' .. cache.spaceLayouts[space])
end

function M.choose(spaceId)
  hs.chooser
    .new(function(layout)
      if layout then
        M.set(layout.text, spaceId)
      end
    end)
    :choices(function()
      return hs.fnutils.map(M.list(), function(name)
        return { text = name }
      end)
    end)
    :show()
end

function M.get(spaceId)
  local space = spaceId or hs.spaces.focusedSpace()
  return cache.spaceLayouts[space]
end

function M.set(layout, spaceId)
  if not hs.fnutils.contains(M.list(), layout) then
    return
  end

  local space = spaceId or hs.spaces.focusedSpace()
  cache.spaceLayouts[space] = layout
  M.show(space)
  utils.tile()
end

return M
