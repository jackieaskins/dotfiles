local wezterm = require('wezterm')
local colors = require('colors')

local components = {}

function components.git_branch(pane)
  local cwd = pane:get_current_working_dir().file_path

  if not cwd then
    return {}
  end

  local branch_cmd = { 'git', '-C', cwd, 'branch', '--show-current' }
  local success, git_branch = wezterm.run_child_process(branch_cmd)

  if success then
    return {
      { Background = { Color = colors.mauve } },
      { Foreground = { Color = colors.bg } },
      {
        Text = table.concat({
          wezterm.nerdfonts.ple_upper_left_triangle,
          wezterm.nerdfonts.dev_git_branch,
          wezterm.split_by_newlines(git_branch)[1],
          wezterm.nerdfonts.ple_lower_right_triangle,
        }, ' '),
      },
    }
  end

  return {}
end

function components.hostname()
  return {
    { Background = { Color = colors.green } },
    { Foreground = { Color = colors.bg } },
    {
      Text = table.concat({
        wezterm.nerdfonts.ple_upper_left_triangle,
        wezterm.nerdfonts.md_monitor,
        wezterm.hostname(),
        '',
      }, ' '),
    },
  }
end

return components
