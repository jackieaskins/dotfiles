local wezterm = require('wezterm')

local act = wezterm.action

local function get_zoxide_results()
  local success, results = wezterm.run_child_process({
    os.getenv('SHELL'),
    '-c',
    'zoxide query --list',
  })

  return success and wezterm.split_by_newlines(results) or {}
end

local function make_choice_id(type, workspace_name, path)
  return table.concat({ type, workspace_name, path }, ':')
end

local function get_choices()
  local existing_workspace_map = {}

  local choices = {}
  for _, workspace in ipairs(wezterm.mux.get_workspace_names()) do
    existing_workspace_map[workspace] = true

    table.insert(choices, {
      id = make_choice_id('existing', workspace, ''),
      label = '[Workspace] ' .. workspace,
    })
  end

  for _, directory in ipairs(get_zoxide_results()) do
    local workspace = directory:gsub('.*%/', '')

    if not existing_workspace_map[workspace] then
      table.insert(choices, {
        id = make_choice_id('zoxide', workspace, directory),
        label = directory:gsub(wezterm.home_dir, '~'),
      })
    end
  end

  return choices
end

local M = {}

function M.open_switcher()
  return wezterm.action_callback(function(window, pane)
    window:perform_action(
      act.InputSelector({
        title = 'Workspace Switcher',
        choices = get_choices(),
        fuzzy = true,
        action = wezterm.action_callback(function(w, p, id)
          if not id then
            return
          end

          local type, workspace, path = id:match('^(.*):(.*):(.*)$')

          if type == 'existing' then
            w:perform_action(act.SwitchToWorkspace({ name = workspace }), p)
          elseif type == 'zoxide' then
            w:perform_action(
              act.SwitchToWorkspace({
                name = workspace,
                spawn = { cwd = path },
              }),
              p
            )

            wezterm.run_child_process({ os.getenv('SHELL'), '-c', 'zoxide add' .. path })
          end
        end),
      }),
      pane
    )
  end)
end

return M
