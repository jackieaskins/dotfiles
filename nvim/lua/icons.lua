local M = {}

---Get the icon and color for a given file path
---@param path string
---@return string, string
function M.get_file_icon(path)
  return require('nvim-web-devicons').get_icon(path, nil, { default = true })
end

return M
