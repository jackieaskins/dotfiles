local M = {}

function M.handleDarkModeChange()
  local successful, isDarkMode =
    hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")

  local appearanceFile = io.open(os.getenv('HOME') .. '/.appearance', 'w')

  if appearanceFile then
    appearanceFile:write((not successful or isDarkMode) and 'dark' or 'light')
    appearanceFile:close()
  end

  hs.execute('tmux source ~/.tmux.conf', true)
end

return M
