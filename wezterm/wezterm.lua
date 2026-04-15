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

config.keys = require('keys')

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

local appearance = wezterm.gui and wezterm.gui.get_appearance()
local cs = require('color_scheme')

local colors = cs.get_colors(appearance)
config.colors = cs.get_color_scheme(appearance)

----------------------------------------------------------------------
--                             Tab Bar                              --
----------------------------------------------------------------------

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false
config.window_frame = {
  font = config.font,
  font_size = config.font_size,
  active_titlebar_bg = colors.bg,
  inactive_titlebar_bg = colors.bg,
}

config.show_tab_index_in_tab_bar = false
wezterm.on('format-tab-title', function(tab)
  return {
    { Text = ' ' },
    { Text = (tab.tab_index + 1) .. ' ' },
    { Text = tab.active_pane.title },
    { Text = ' ' },
  }
end)

require('status')

----------------------------------------------------------------------
--                              Window                              --
----------------------------------------------------------------------

config.window_decorations = 'RESIZE'
config.adjust_window_size_when_changing_font_size = false
config.window_padding = { left = 0, right = 0, top = '0.5cell', bottom = 0 }
config.window_content_alignment = { horizontal = 'Center', vertical = 'Center' }

return config
