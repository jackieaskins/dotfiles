local M = {}

---Merge multiple tables together
---@param ... table
---@return table
function M.mergeTables(...)
  local rv = {}

  for _, tbl in ipairs({ ... }) do
    for key, value in pairs(tbl) do
      rv[key] = value
    end
  end

  return rv
end

return M
