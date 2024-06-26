local watcher = vim.uv.new_fs_event()
local theme_file = vim.fn.expand('~/dotfiles/theme')

local function set_background(is_reload)
  local file = io.open(theme_file, 'r')
  local background = file and file:read() or 'dark'
  vim.opt.background = background

  if is_reload then
    require('plugins.web-devicons').load_icons(true)
    require('tint').refresh()
  end
end

local function watch_for_theme_change()
  if not watcher then
    return
  end

  watcher:start(
    theme_file,
    {},
    vim.schedule_wrap(function()
      set_background(true)
    end)
  )
end

set_background(false)
watch_for_theme_change()
