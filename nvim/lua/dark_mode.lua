local watcher = vim.uv.new_fs_event()
local theme_file = vim.fn.expand('~/dotfiles/theme')

local function set_background(is_reload)
  local file = io.open(theme_file, 'r')
  local background = file and file:read() or 'dark'
  vim.o.background = background

  if is_reload then
    local ok, tint = pcall(require, 'tint')
    if ok then
      tint.refresh()
    end
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
