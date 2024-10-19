local watcher = vim.uv.new_fs_event()
local appearance_file = vim.fn.expand('~/.appearance')

local function set_background()
  local file = io.open(appearance_file, 'r')
  local background = file and file:read() or 'dark'
  vim.o.background = background
end

set_background()
if watcher then
  watcher:start(appearance_file, {}, vim.schedule_wrap(set_background))
end
