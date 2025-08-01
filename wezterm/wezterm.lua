local wezterm = require('wezterm')
local config = wezterm.config_builder()

----------------------------------------------------------------------
--                             General                              --
----------------------------------------------------------------------

config.set_environment_variables = {
  TERMINFO_DIRS = '/run/current-system/sw/share/terminfo',
}
config.term = 'wezterm'
config.force_reverse_video_cursor = true
config.swallow_mouse_click_on_pane_focus = true

----------------------------------------------------------------------
--                               Keys                               --
----------------------------------------------------------------------
config.keys = {
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

----------------------------------------------------------------------
--                               Font                               --
----------------------------------------------------------------------

config.font = wezterm.font({ family = 'Mononoki Nerd Font' })
config.font_size = 14
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } -- disable ligatures
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'

----------------------------------------------------------------------
--                           Color Scheme                           --
----------------------------------------------------------------------

local cs = require('color_scheme')
local colors = cs.colors

config.color_scheme = cs.name
config.colors = colors

----------------------------------------------------------------------
--                             Tab Bar                              --
----------------------------------------------------------------------

config.show_close_tab_button_in_tabs = false
config.show_tab_index_in_tab_bar = false
config.window_frame = {
  font = config.font,
  font_size = config.font_size,
  active_titlebar_bg = colors.background,
  inactive_titlebar_bg = colors.background,
}
config.hide_tab_bar_if_only_one_tab = true

wezterm.on('format-tab-title', function(tab, tabs)
  return {
    { Text = ' ' },
    { Text = #tabs > 1 and (tab.tab_index + 1) .. ' ' or '' },
    { Text = tab.active_pane.title },
    { Text = ' ' },
  }
end)

----------------------------------------------------------------------
--                              Window                              --
----------------------------------------------------------------------

config.window_decorations = 'RESIZE'
config.adjust_window_size_when_changing_font_size = false
config.window_padding = { left = 0, right = 0, top = '0.5cell', bottom = '0.5cell' }
config.window_content_alignment = {
  horizontal = 'Center',
  vertical = 'Center',
}

return config
