local watcher = vim.uv.new_fs_event()
local appearance_file = vim.fn.expand('~/.appearance')

if watcher then
  watcher:start(
    appearance_file,
    {},
    vim.schedule_wrap(function()
      local file = io.open(appearance_file, 'r')
      local background = file and file:read() or 'dark'
      vim.o.background = background
    end)
  )
end
