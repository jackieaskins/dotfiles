local wezterm = require('wezterm')

local appearance = wezterm.gui and wezterm.gui.get_appearance() or 'Dark'
local color_scheme_name = appearance:find('Light') and 'Catppuccin Latte' or 'Catppuccin Macchiato'

local color_scheme = wezterm.color.get_builtin_schemes()[color_scheme_name]

-- Use mauve instead of pink for purple terminal color
local ansi = color_scheme.ansi
ansi[6] = color_scheme.tab_bar.active_tab.bg_color

local brights = color_scheme.brights
brights[6] = ansi[6]

local accent = ansi[5]

local colors = {
  ansi = ansi,
  background = color_scheme.background,
  brights = brights,
  tab_bar = {
    active_tab = {
      fg_color = accent,
      bg_color = color_scheme.visual_bell,
    },
    inactive_tab = {
      fg_color = color_scheme.scrollbar_thumb,
      bg_color = color_scheme.background,
    },
    inactive_tab_hover = {
      fg_color = accent,
      bg_color = color_scheme.background,
    },
    inactive_tab_edge = color_scheme.background,
    new_tab = {
      bg_color = color_scheme.background,
      fg_color = accent,
    },
    new_tab_hover = {
      fg_color = color_scheme.visual_bell,
      bg_color = accent,
    },
  },
}

return {
  name = color_scheme_name,
  colors = colors,
}
