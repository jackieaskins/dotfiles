local M = {}

function M.get_colors()
  return require('catppuccin.palettes').get_palette() or {}
end

return M
