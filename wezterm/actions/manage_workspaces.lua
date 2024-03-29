local wezterm = require('wezterm')
local act = wezterm.action

local utils = require('utils')
local workspaces = require('workspaces')

local function create_workspace(window, pane, id)
  local config = workspaces[id]
  local cwd, tabs = config.cwd, config.tabs

  local win = nil
  for _, tab_config in ipairs(tabs) do
    local tab = nil
    local pn = nil

    if win == nil then
      tab, pn, win = wezterm.mux.spawn_window({ workspace = id, cwd = tab_config.cwd or cwd })
    else
      tab, pn = win:spawn_tab({ cwd = tab_config.cwd or cwd })
    end

    if tab_config.cmd then
      pn:send_text(tab_config.cmd .. '\n')
    end

    tab:set_title(tab_config.title)
  end

  window:perform_action(act.SwitchToWorkspace({ name = id }), pane)
  window:perform_action(act.ActivateTab(0), pane)
end

local function get_all_workspaces(existing_workspaces)
  local all_workspaces = {}

  local active_workspace = wezterm.mux.get_active_workspace()

  for workspace, _ in pairs(workspaces) do
    all_workspaces[workspace] = { id = workspace, label = workspace, exists = false }
  end

  for _, workspace in ipairs(existing_workspaces) do
    all_workspaces[workspace] =
      { id = workspace, label = workspace, exists = true, active = workspace == active_workspace }
  end

  local workspace_arr = utils.tbl_values(all_workspaces)
  table.sort(workspace_arr, function(ws1, ws2)
    return ws1.label < ws2.label
  end)

  return workspace_arr
end

local function get_choices(existing_workspaces)
  local all_workspaces = get_all_workspaces(existing_workspaces)

  local choices = {}

  for _, val in ipairs(all_workspaces) do
    local id, label, exists, active = val.id, val.label, val.exists, val.active

    table.insert(choices, {
      id = id,
      label = wezterm.format({
        { Attribute = { Intensity = exists and 'Bold' or 'Normal' } },
        { Attribute = { Italic = not exists } },
        { Text = label .. (active and ' *' or '') },
      }),
    })
  end

  table.insert(choices, { id = '**create**', label = 'Create new workspace' })

  return choices
end

return wezterm.action_callback(function(window, pane)
  local existing_workspaces = wezterm.mux.get_workspace_names()

  window:perform_action(
    act.InputSelector({
      title = 'Select workspace name',
      choices = get_choices(existing_workspaces),
      action = wezterm.action_callback(function(w, p, id)
        if not id then
          return
        end

        if id == '**create**' then
          w:perform_action(act.SwitchToWorkspace, p)
        elseif utils.list_contains(existing_workspaces, id) then
          w:perform_action(act.SwitchToWorkspace({ name = id }), p)
        else
          create_workspace(w, p, id)
        end
      end),
    }),
    pane
  )
end)
