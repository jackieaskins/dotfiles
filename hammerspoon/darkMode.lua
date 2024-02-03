local M = {}

---Returns whether or not the system is set to use dark mode
---@return boolean
function M.isDarkMode()
  local _, isDarkMode = hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")

  ---@diagnostic disable-next-line: return-type-mismatch
  return isDarkMode
end

---Writes to a file used by neovim to determine system color, executes scripts to update kitty and tmux colors
function M.configureSystemColors()
  local isDarkMode = M.isDarkMode()

  local file = io.open(os.getenv('HOME') .. '/dotfiles/theme', 'w')
  if file then
    file:write(isDarkMode and 'dark' or 'light')
    file:close()
  end

  hs.execute(
    string.format(
      '%s/bin/kitty +kitten themes --reload-in=all --config-file-name theme.conf %s',
      BREW_PREFIX,
      isDarkMode and 'Catppuccin-Macchiato' or 'Catppuccin-Latte'
    )
  )

  hs.execute(
    string.format('%s/dotfiles/bin/set-tmux-theme "%s"', os.getenv('HOME'), isDarkMode and 'dark' or 'light'),
    true
  )

  hs.alert.show(isDarkMode and 'Dark mode enabled' or 'Light mode enabled')
end

return M
