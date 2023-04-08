local color_scheme = require('color_scheme')

local ansi = color_scheme.ansi
local brights = color_scheme.brights

---@type table<string, string>
return {
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
