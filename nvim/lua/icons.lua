local M = {}

local default_icon = ''

---Get the icon and color for a given file path
---@param path string
---@return string, string
function M.get_file_icon(path)
  local ok, icons = pcall(require, 'nvim-web-devicons')

  if ok then
    return icons.get_icon(path, nil, { default = true })
  end

  return default_icon, '#fff'
end

---Get the icon and color for a given filetype
---@param filetype string
---@return string, string
function M.get_filetype_icon(filetype)
  local ok, icons = pcall(require, 'nvim-web-devicons')

  if ok then
    return icons.get_icon_by_filetype(filetype, { default = true })
  end

  return default_icon, '#fff'
end

return M
