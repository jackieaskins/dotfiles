local M = {}

---Returns function that checks node and its ancestors for supported/unsupported node types
---@param supported_node_types string[]
---@param unsupported_node_types string[]
---@return fun(node: TSNode?): TSNode?
function M.find_supported_node(supported_node_types, unsupported_node_types)
  local function find(node)
    if not node or vim.tbl_contains(unsupported_node_types, node:type()) then
      return nil
    end

    if vim.tbl_contains(supported_node_types, node:type()) then
      return node
    end

    return find(node:parent())
  end

  return find
end

return M
