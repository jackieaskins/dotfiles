twmMenubar = hs.menubar.new(true, 'twm'):setTooltip('Tiling Window Manager'):setMenu(function()
  local mainScreenUUID = hs.screen.mainScreen():getUUID()
  local workspacesByScreenUUID = twm:getWorkspacesByScreenUUID()

  return hs.fnutils.reduce(twm.screenUUIDs, function(accum, screenUUID)
    local workspaces = workspacesByScreenUUID[screenUUID] or {}

    table.insert(accum, {
      title = hs.screen.find(screenUUID):name(),
      checked = mainScreenUUID == screenUUID,
      menu = hs.fnutils.imap(
        workspaces,
        ---@param workspace VirtualWorkspace
        function(workspace)
          return {
            title = 'Workspace ' .. workspace.id,
            checked = workspace.isVisible,
          }
        end
      ),
    })

    table.insert(accum, { title = '-' })

    return accum
  end, {})
end)

assert(twmMenubar)

local function setTitle()
  local focusedScreenUUID = hs.screen.mainScreen():getUUID()

  local title = table.concat(
    fnutils.imap(twm:getVisibleWorkspaces(), function(workspace)
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
