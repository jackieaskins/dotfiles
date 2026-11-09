local M = {}

function M.handleDarkModeChange()
  local successful, isDarkMode =
    hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")
  local useDarkMode = not successful or isDarkMode

  local home = os.getenv('HOME')

  local appearanceFile = io.open(home .. '/.appearance', 'w')
  if appearanceFile then
    appearanceFile:write(useDarkMode and 'dark' or 'light')
    appearanceFile:close()
  end

  hs.execute('tmux source ~/.tmux.conf', true)

  local claudeFlavor = useDarkMode and 'mocha' or 'latte'
  local themeFilePath = home .. '/.claude/themes/catppuccin.json'
  local flavorFilePath = string.format('%s/.claude/themes/catppuccin-%s.json', home, claudeFlavor)
  local flavorFile = io.open(flavorFilePath, 'r')
  if flavorFile then
    flavorFile:close()
    hs.execute(string.format('ln -sf %s %s', flavorFilePath, themeFilePath), true)
  end
end

return M
