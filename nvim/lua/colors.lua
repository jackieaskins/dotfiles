local M = {}

function M.get_colors()
  local ok, palettes = pcall(require, 'catppuccin.palettes')
  return ok and palettes.get_palette() or {}
end

return M
