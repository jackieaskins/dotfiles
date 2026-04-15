local wezterm = require('wezterm')
local color_scheme = require('color_scheme')

local function get_git_branch(pane)
  local cwd = pane:get_current_working_dir()

  if not cwd then
    return nil
  end

  local branch_cmd = { 'git', '-C', cwd.file_path, 'branch', '--show-current' }
  local success, branch = wezterm.run_child_process(branch_cmd)

  return success and branch or nil
end

local function mk_status_component(components)
  local output = {}

  for _, component in ipairs(components) do
    table.insert(output, { Foreground = { Color = component.fg } })
    table.insert(output, { Background = { Color = component.bg } })
    table.insert(output, {
      Text = table.concat({ '', component.icon, component.text }, ' '),
    })
  end

  return wezterm.format(output)
end

wezterm.on('update-status', function(window, pane)
  local colors = color_scheme.get_colors(window:get_appearance())

  window:set_left_status(mk_status_component({
    {
      icon = wezterm.nerdfonts.dev_terminal,
      text = window:active_workspace() .. ' ',
      fg = colors.bg,
      bg = colors.pink,
    },
  }))

  local right_status = {}

  local git_branch = get_git_branch(pane)
  if git_branch then
    table.insert(right_status, {
      icon = wezterm.nerdfonts.dev_git_branch,
      text = git_branch:gsub('%s+', '') .. ' ',
      fg = colors.bg,
      bg = colors.mauve,
    })
  end

  table.insert(right_status, {
    icon = wezterm.nerdfonts.md_monitor,
    text = wezterm.hostname(),
    fg = colors.bg,
    bg = colors.green,
  })

  window:set_right_status(mk_status_component(right_status))
end)
