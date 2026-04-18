local wezterm = require('wezterm')

local function get_default_color_scheme(appearance)
  appearance = appearance or 'Dark'
  local name = appearance:find('Light') and 'Catppuccin Latte' or 'Catppuccin Mocha'
  return wezterm.color.get_builtin_schemes()[name]
end

local M = {}

function M.get_colors(appearance)
  local color_scheme = get_default_color_scheme(appearance)

  local ansi = color_scheme.ansi
  local brights = color_scheme.brights

  local colors = {
    fg = color_scheme.foreground,
    bg = color_scheme.background,

    red = ansi[2],
    green = ansi[3],
    yellow = ansi[4],
    blue = ansi[5],
    pink = ansi[6],
    teal = ansi[7],
    peach = color_scheme.indexed[16],
    rosewater = color_scheme.indexed[17],
    mauve = color_scheme.tab_bar.active_tab.bg_color,

    subtext0 = brights[8],
    subtext1 = ansi[8],

    surface0 = color_scheme.visual_bell,
    surface1 = ansi[1],
    surface2 = brights[1],
  }

  return colors
end

function M.get_color_scheme(appearance)
  local color_scheme = get_default_color_scheme(appearance)
  local colors = M.get_colors(appearance)

  -- Overrides
  local accent = colors.blue

  color_scheme.split = accent

  -- Use mauve instead of pink for purple terminal color
  color_scheme.ansi[6] = colors.mauve
  color_scheme.brights[6] = colors.mauve

  -- Tab Bar
  color_scheme.tab_bar.background = colors.bg

  -- Active Tab
  color_scheme.tab_bar.active_tab.fg_color = accent
  color_scheme.tab_bar.active_tab.bg_color = colors.surface0

  -- Inactive Tab
  color_scheme.tab_bar.inactive_tab.fg_color = colors.surface1
  color_scheme.tab_bar.inactive_tab.bg_color = colors.bg

  color_scheme.tab_bar.inactive_tab_hover.fg_color = accent
  color_scheme.tab_bar.inactive_tab_hover.bg_color = colors.bg

  color_scheme.tab_bar.inactive_tab_edge = colors.bg

  -- New Tab
  color_scheme.tab_bar.new_tab.bg_color = colors.bg
  color_scheme.tab_bar.new_tab.fg_color = accent

  color_scheme.tab_bar.new_tab_hover.fg_color = colors.surface0
  color_scheme.tab_bar.new_tab_hover.bg_color = accent

  return color_scheme
end

return M
