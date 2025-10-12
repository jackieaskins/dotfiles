twmMenubar = hs.menubar.new(true, 'twm'):setTooltip('Tiling Window Manager'):setMenu(function()
  return hs.fnutils.reduce(twm.screenUUIDs, function(accum, screenUUID)
    local mainScreenUUID = hs.screen.mainScreen():getUUID()

    table.insert(accum, {
      title = hs.screen.find(screenUUID):name(),
      checked = mainScreenUUID == screenUUID,
    })

    return accum
  end, {})
end)

assert(twmMenubar)

local function setTitle()
  local focusedScreenUUID = hs.screen.mainScreen():getUUID()

  local title = table.concat(
    fnutils.imap(twm:getActiveWorkspaces(), function(workspace)
      return table.concat({
        tostring(workspace.id),
        focusedScreenUUID == workspace.screenUUID and '*' or '',
      })
    end),
    ' | '
  )

  twmMenubar:setTitle(title)
end

setTitle()

EventListener.subscribe(EventListener.events.activeSpacesChanged, function()
  setTitle()
end)
