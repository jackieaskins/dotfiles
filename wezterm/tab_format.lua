local wezterm = require('wezterm')
local colors = require('colors')

local function get_tab_title(tab)
  local title = tab.tab_title

  if title and #title > 0 then
    return title
  end

  return tab.active_pane.title
end

wezterm.on('format-tab-title', function(tab)
  local edge_background = colors.bg
  local background = tab.is_active and colors.blue or colors.surface0
  local foreground = tab.is_active and colors.bg or colors.fg
  local edge_foreground = background

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = wezterm.nerdfonts.ple_upper_right_triangle },

    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = ' ' .. (tab.tab_index + 1) .. ' ' .. get_tab_title(tab) .. ' ' },

    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = wezterm.nerdfonts.ple_lower_left_triangle },
  }
end)
