---Write to file that is watched by neovim instances to determine light/dark theme
---@param isDarkMode boolean
local function writeNeovimThemeFile(isDarkMode)
  local neovimFile = io.open(os.getenv('HOME') .. '/dotfiles/theme', 'w')
  if neovimFile then
    neovimFile:write(isDarkMode and 'dark' or 'light')
    neovimFile:close()
  end
end

---Write current theme to bat config file
---@param theme string
local function writeBatConfigFile(theme)
  local batFile = io.open(os.getenv('HOME') .. '/dotfiles/bat/config', 'w')
  if batFile then
    batFile:write('--theme="Catppuccin ' .. theme .. '"')
    batFile:close()
  end
end

---Set the current kitty theme
---@param theme string
local function setKittyTheme(theme)
  hs.execute(
    string.format(
      '%s/bin/kitty +kitten themes --reload-in=all --config-file-name theme.conf %s',
      BREW_PREFIX,
      'Catppuccin-' .. theme
    )
  )
end

---Call script to set tmux theme based on dark/light mode
---@param isDarkMode boolean
local function setTmuxTheme(isDarkMode)
  hs.execute(
    string.format('%s/dotfiles/bin/set-tmux-theme "%s"', os.getenv('HOME'), isDarkMode and 'dark' or 'light'),
    true
  )
end

local M = {}

---Returns whether or not the system is set to use dark mode
---@return boolean
function M.isDarkMode()
  local _, isDarkMode = hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")

  ---@diagnostic disable-next-line: return-type-mismatch
  return isDarkMode
end

---Updates Bat, kitty, Neovim, and Tmux colors when system color changes
function M.configureSystemColors()
  local isDarkMode = M.isDarkMode()
  local theme = isDarkMode and 'Macchiato' or 'Latte'

  setKittyTheme(theme)
  setTmuxTheme(isDarkMode)
  writeNeovimThemeFile(isDarkMode)
  writeBatConfigFile(theme)

  hs.alert.show(isDarkMode and 'Dark mode enabled' or 'Light mode enabled')
end

return M
