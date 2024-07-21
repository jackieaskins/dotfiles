local M = {}

---Get the icon and color for a given filetype
---@param filetype string
---@return string, string
function M.get_filetype_icon(filetype)
  if MiniIcons then
    local ok, icon, color = pcall(MiniIcons.get, 'filetype', filetype)

    if ok then
      ---@diagnostic disable-next-line: return-type-mismatch
      return icon, color
    end
  end

  return '', 'MiniIconsGrey'
end

return M
