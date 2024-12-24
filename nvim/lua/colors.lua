local M = {}

---Get Catppuccin color palette
---@return table<string, CtpColors>
function M.get_colors()
  local ok, palettes = pcall(require, 'catppuccin.palettes')
  return ok and palettes.get_palette() or {}
end

return M
