local wezterm = require('wezterm')

local utils = {}

---Generate a path relevative to the home dir
---Example: { 'dotfiles', 'wezterm' } becomes ~/dotfiles/wezterm
---@param parts string[]
---@return string
function utils.home_path(parts)
  table.insert(parts, 1, wezterm.home_dir)
  return table.concat(parts, '/')
end

---Return whether a list-like table contains an item
---@generic T
---@param list T[]
---@param item T
---@return boolean
function utils.list_contains(list, item)
  for _, value in ipairs(list) do
    if item == value then
      return true
    end
  end

  return false
end

---Merge two or more map-like tables
---@param ... table
---@return table
function utils.tbl_extend(...)
  local new_tbl = {}

  for _, tbl in ipairs({ ... }) do
    for key, value in pairs(tbl) do
      new_tbl[key] = value
    end
  end

  return new_tbl
end

---Get all of the values from a map-like table
---@generic T
---@param tbl table<string, T>
---@return T[]
function utils.tbl_values(tbl)
  local values = {}

  for _, value in pairs(tbl) do
    table.insert(values, value)
  end

  return values
end

return utils
