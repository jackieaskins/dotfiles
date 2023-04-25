local wezterm = require('wezterm')
local colors = require('colors')
local components = require('status.components')

wezterm.on('update-status', function(window, pane)
  local right_status = {}

  for _, part in ipairs({
    components.git_branch(pane),
    components.hostname(),
  }) do
    for _, line in ipairs(part) do
      table.insert(right_status, line)
    end
  end

  window:set_right_status(wezterm.format(right_status))
  window:set_left_status(wezterm.format({
    { Background = { Color = colors.pink } },
    { Foreground = { Color = colors.bg } },
    {
      Text = table.concat({
        '',
        wezterm.nerdfonts.dev_terminal,
        window:active_workspace(),
        wezterm.nerdfonts.ple_upper_right_triangle,
      }, ' '),
    },
  }))
end)
