local wezterm = require('wezterm')

local color_scheme = wezterm.color.get_builtin_schemes()['Catppuccin Macchiato']
color_scheme.tab_bar.background = color_scheme.background

return color_scheme
