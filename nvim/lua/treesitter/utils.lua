local M = {}

---Replace node text with provided text
---@param node TSNode
---@param lines string[]
function M.replace_node_text(node, lines)
  local sr, sc, er, ec = node:range(false)
  vim.api.nvim_buf_set_text(0, sr, sc, er, ec, lines)
end

---Search up from node to find parent of type
---@param node TSNode | nil
---@param parent_type string | string[]
---@return TSNode | nil
function M.find_node_parent(node, parent_type)
  if node == nil then
    return nil
  end

  local function matches_parent_type()
    if type(parent_type) == 'string' then
      return node:type() == parent_type
    end

    return vim.tbl_contains(parent_type, node:type())
  end

  if matches_parent_type() then
    return node
  end

  return M.find_node_parent(node:parent(), parent_type)
end

return M
