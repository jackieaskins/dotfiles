local M = {}

---Get the icon and color for a given file path
---@param path string
---@return string icon, string color
function M.get_file_icon(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')

  local icon = require('nvim-web-devicons').get_icon(filename, extension)

  return icon == '' and nil or icon
end

return M
